# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation

  has_many :check_records

  def username
    email.split('@').first
  end

  alias to_s username
  def avatar(size: 80)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def password_required?
    return false if skip_password_validation
    super
  end

  def self.registrar_or_checkin_staff(card_serial)
    user = find_by(card_serial: card_serial)
    return registrar(card_serial) if user.nil?
    checkin_staff(user)
  end

  def checkin
    check_records.create! if check_records.active.empty?
  end

  def register(serial)
    return if card_serial.present?
    update_attributes(card_serial: serial)
  end

  def self.registrar(card_serial)
    # TODO: Modified use channel register method to find event and register card_serial
    user = find(1)
    result = user.register(card_serial)
    return nil unless result
    # TODO: Action cable broadcast bind card_serial
    { auth: true, reason: 'registrar' }
  end

  def self.checkin_staff(user)
    result = user.checkin
    return nil unless result
    # TODO: Action cable broadcast new record
    { auth: true, reason: 'checkin' }
  end
end
