# frozen_string_literal: true
# Registrar Channel
class RegistrarChannel < ApplicationCable::Channel
  EVENTS = {
    register: 'REGISTER',
    success: 'REGISTER_SUCCESS',
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def register(registrar, serial, packet_id)
      broadcast_to('registrar_channel', type: EVENTS[:register], serial: serial, packet_id: packet_id)
    end

    def update(attendee)
      broadcast_to('registrar_channel', type: EVENTS[:update], attendee: attendee)
    end
  end

  def follow()
    stop_all_streams
    stream_for 'registrar_channel'
  end

  def unfollow
    stop_all_streams
  end

  # TODO: Improve this method AbcSize
  # rubocop:disable Metrics/AbcSize
  def register(data)
    user = User.find(data['attendeeId'])
    packet_id = data['packet_id']
    serial = data['serial']
    return TamashiiRailsHook.machine_write(packet_id, { auth: false, reason: 'registrar' }) unless user.register(serial)
    RegistrarChannel.broadcast_to('registrar_channel', type: EVENTS[:success], attendee: user)
    TamashiiRailsHook.machine_write(packet_id, { auth: true, reason: 'registrar' })
  end
end
