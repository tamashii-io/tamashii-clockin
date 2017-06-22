# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :check_records

  def checkin
    check_records.create! if check_records.active.empty?
  end

  def self.register(card_serial)
    logger.info card_serial
    user = User.find_by(card_serial: card_serial)
    unless user.nil?
      user.checkin
      # TODO: Action cable broadcast new checkreocrd record
      return false
    end
    # TODO: Action cable broadcast bind card_serial
    true
  end
end
