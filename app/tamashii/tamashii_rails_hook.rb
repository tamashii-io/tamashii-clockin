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
                   @packet_id, @card_id = unpack(packet)
                   user = User.find_by(card_serial: @card_id)
                   registrar_or_checkin(user)
                 end
    response type, data unless type.nil? || data.nil?
  end

  def response(type, data)
    packet = Tamashii::Packet.new(type, @client.tag, data)
    @client.send(packet.dump)
  end

  def registrar
    result = User.register(@card_id)
    return [nil, nil] if result.nil?
    [Tamashii::Type::RFID_RESPONSE_JSON, pack(auth: true, reason: 'registrar')]
  end

  def checkin(user)
    result = user.checkin
    return [nil, nil] unless result
    [Tamashii::Type::RFID_RESPONSE_JSON, pack(auth: true, reason: 'checkin')]
  end

  def pack(**body)
    {
      id: @packet_id,
      ev_body: body.to_json
    }.to_json
  end

  def unpack(packet)
    json = JSON.parse(packet.body)
    [json['id'], json['ev_body']]
  end

  def registrar_or_checkin(user)
    if user.nil?
      registrar
    else
      checkin(user)
    end
  end

  private

  def interested?(packet)
    INTERESTED_TYPES.include?(packet.type)
  end
end
