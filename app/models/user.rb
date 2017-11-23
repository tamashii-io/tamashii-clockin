# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:gitlab]

  validates :card_serial, uniqueness: { allow_blank: true }

  has_many :check_records
  has_many :machines
  after_save -> { RegistrarChannel.update(self) }

  default_scope -> { where(deleted: false) }
  scope :managers, -> { where(deleted: false, admin: true) }

  after_save :delete_check_records, if: :delete_check_records?
  enum job_type: {
    full_time: 0,
    intern: 1
  }

  def username
    email.split('@').first
  end

  alias to_s username
  def avatar(size: 80)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def self.registrar_or_checkin_staff(machine_serial, card_serial, packet_id)
    user = find_by(card_serial: card_serial)
    machine ||= Machine.find_by(serial: machine_serial)
    return registrar(machine_serial, card_serial, packet_id, machine, user) if machine.registrar?
    checkin_staff(user)
  end

  def checkin
    check_records.create! if check_records.active.empty?
  end

  def register(serial)
    return if card_serial.present?
    update_attributes(card_serial: serial)
  end

  def self.registrar(machine_serial, card_serial, packet_id, machine, user)
    return false unless user.nil?
    return false if machine.registrar.blank?
    RegistrarChannel.register('registrar_channel', machine_serial, card_serial, packet_id)
    nil
  end

  def self.checkin_staff(user)
    return false if user.nil?
    result = user.checkin
    return nil unless result
    greeting = generate_greeting(user)
    { auth: true, reason: 'checkin', message: "#{greeting}\n#{user.ascii_only_name}" }
  end

  def self.generate_greeting(user)
    if (user.check_records.today.count % 2).zero?
      # clock out
      clock_out_greeting
    else
      # clock in
      clock_in_greeting
    end
  end

  def self.compute_late_time(time_now, time_limit)
    seconds = time_now - time_limit
    min = (seconds / 60.0).ceil
    hour = min / 60
    min %= 60
    [hour, min]
  end

  def self.clock_in_greeting
    time_limit = Time.zone.parse(Settings.clockin_time_limit)
    time_now = Time.zone.now
    if time_now > time_limit # Late
      hour, min = compute_late_time(time_now, time_limit)
      "Late for #{hour}h#{min}m!"
    else # In time
      'Hello'
    end
  end

  def self.clock_out_greeting
    'Good Bye!'
  end

  def ascii_only_name
    if name.ascii_only?
      name
    else
      email.split('@').first
    end
  end

  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    unless user.nil?
      user.update_attributes(gitlab_id: auth.uid)
      return user
    end
    create(email: auth.info.email, gitlab_id: auth.uid, password: Devise.friendly_token[0, 20])
  end

  private

  def delete_check_records?
    deleted_changed? && deleted
  end

  def delete_check_records
    check_records.find_each { |record| record.update(deleted: true) }
  end
end
