# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :check_records

  def checkin
    if check_records.active.empty?
      self.check_records.create!
      puts "Here!!!"
    else
      puts "Wait!!!"
    end
  end

  def latest_record
    check_records.active
  end
end
