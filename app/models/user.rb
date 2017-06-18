# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :check_records

  def checkin
    if check_records.active.empty?
      if check_records.length == 0
        check_records.create.set_type(0)
      else
        check_records.create.set_type(find_type)
      end
    end
  end

  def find_type
    last_record = check_records[check_records.length-2].created_at
    if Time.at(last_record).to_date != Time.at(Time.now).to_date
      0
    elsif check_records[check_records.length-2].type == 0
      1
    else
      0
    end
  end

end
