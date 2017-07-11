# frozen_string_literal: true

# Registrar Channel

class RegistrarChannel < ApplicationCable::Channel
  EVENTS = {
    start_register: 'START_REGISTER',
    register: 'REGISTER',
    success: 'REGISTER_SUCCESS',
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def register(registrar, machine_serial, card_serial, packet_id)
      broadcast_to(registrar, type: EVENTS[:register], machine_serial: machine_serial, card_serial: card_serial, packet_id: packet_id)
    end

    def update(user)
      broadcast_to('registrar_channel', type: EVENTS[:update], user: user)
    end
  end

  def follow
    stop_all_streams
    stream_for 'registrar_channel'
    stream_for current_user
  end

  def unfollow
    stop_all_streams
  end

  def register(data)
    user = User.find(data['userId'])
    packet_id = data['packet_id']
    card_serial = data['card_serial']
    machine_serial = data['machine_serial']
    return TamashiiRailsHook.response_register_status(machine_serial, packet_id, false) unless user.register(card_serial)
    RegistrarChannel.broadcast_to('registrar_channel', type: EVENTS[:success], user: user)
    TamashiiRailsHook.response_register_status(machine_serial, packet_id, true)
  end

  def start_or_cancel_register(data)
    return RegistrarChannel.broadcast_to('registrar_channel', type: EVENTS[:start_register], broadcast: false) if data['userId'].nil?
    RegistrarChannel.broadcast_to('registrar_channel', type: EVENTS[:start_register], userId: data['userId'], broadcast: false)
  end
end
