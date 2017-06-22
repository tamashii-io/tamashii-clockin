# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :check_records

  def checkin
    # TODO: Action cable broadcast new record
    check_records.create! if check_records.active.empty?
  end

  def self.register(card_serial)
    logger.info card_serial
    # TODO: Action cable broadcast bind card_serial
    true
  end
end
