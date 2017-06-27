# frozen_string_literal: true

require_relative 'tamashii/manager/client'

# Tamashii Rails Hook
class TamashiiRailsHook < Tamashii::Hook
  INTERESTED_TYPES = [Tamashii::Type::RFID_NUMBER, Tamashii::Type::RFID_DATA].freeze

  def initialize(*args)
    super
    @client = @env[:client]
  end

  def call(packet)
    return unless @client.authorized?
    return unless interested?(packet)
    handle(packet)

    true
  end

  def handle(packet)
    type, data = case packet.type
                 when Tamashii::Type::RFID_NUMBER
                   packet_id, card_id = unpack(packet)
                   result = User.registrar_or_checkin_staff(@client.id, card_id, packet_id)
                   return [nil, result] if result.nil?
                   [Tamashii::Type::RFID_RESPONSE_JSON, pack(packet_id, result)]
                 end
    response type, data unless type.nil? || data.nil?
  end

  def response(type, data)
    packet = Tamashii::Packet.new(type, @client.tag, data)
    @client.send(packet.dump)
  end

  def pack(packet_id, **body)
    {
      id: packet_id,
      ev_body: body.to_json
    }.to_json
  end

  def unpack(packet)
    json = JSON.parse(packet.body)
    [json['id'], json['ev_body']]
  end

  class << self
    def build_register_packet(packet_id, result)
      {
        id: packet_id,
        ev_body: {
          auth: result,
          reason: 'registrar'
        }.to_json
      }.to_json
    end

    def response_register_status(serial, packet_id, result)
      type = Tamashii::Type::RFID_RESPONSE_JSON
      data = build_register_packet(packet_id, result)
      packet = Tamashii::Packet.new(type, 0, data)
      Tamashii::Manager::Client.send_to(serial, packet.dump)
    end
  end

  private

  def interested?(packet)
    INTERESTED_TYPES.include?(packet.type)
  end
end
