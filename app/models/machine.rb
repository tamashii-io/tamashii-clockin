# frozen_string_literal: true

# :nodoc:
class Machine < ApplicationRecord
  self.inheritance_column = :_type

  belongs_to :registrar, class_name: 'User', optional: true

  scope :recent_update, -> { where(updated_at: 5.minutes.ago..Float::INFINITY) }

  enum type: {
    clockin: 0,
    registrar: 1
  }

  def write(packet)
    Tamashii::Manager::Client.send_to(serial, packet.dump)
  end

  # TODO: Use ruby auto generate below code
  def beep(type = 'ok')
    process_command :beep, type
  end

  def restart
    process_command :restart
  end

  def reboot
    process_command :reboot
  end

  def poweroff
    process_command :poweroff
  end

  def update
    process_command :update
  end

  def to_s
    name
  end

  private

  def process_command(command, options = nil)
    Tamashii::Commander.new(self, command).process(options)
  end
end
