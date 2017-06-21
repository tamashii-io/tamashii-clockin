# frozen_string_literal: true

require_relative 'tamashii/manager/client'

# Tamashii Rails Hook
class TamashiiRailsHook < Tamashii::Hook
  INTERESTED_TYPES = [Tamashii::Type::RFID_NUMBER, Tamashii::Type::RFID_DATA].freeze

  def initialize(*args)
    super
    @client = @env[:client]
    puts "fkofjo"
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
                   # TODO: Crad serial will raded from here
                   json = JSON.parse(packet.body)
                   packet_id, card_id = [json['id'], json['ev_body']]
                   [Tamashii::Type::RFID_DATA, {id: packet_id}.to_json]
                 end
    response type, data unless type.nil? || data.nil?
  end

  def response(type, data)
    packet = Tamashii::Packet.new(type, @client.tag, data)
    @client.send(packet.dump)
  end

  private

  def interested?(packet)
    INTERESTED_TYPES.include?(packet.type)
  end

  def pack(body)
    {
      id: packet_id,
      ev_body: body.to_json
    }.json
  end

  def unpack
    json = JSON.parse(@packet.body)
    [json['id'], json['ev_body']]
  end
end
