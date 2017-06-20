# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :check_records

  def checkin
    not_active = check_records.active.empty?
    first_records = check_records.length.zero?
    if first_records && not_active
      check_records.create.assign_type(0)
    elsif not_active
      check_records.create.assign_type(find_type)
    end
  end

  def find_type
    index = check_records.length - 2
    last_record = check_records[index].created_at
    return 0 if date(last_record) != date(Time.current) || check_records[index].type.nonzero?
    1
  end

  private

  def date(x)
    Time.zone.at(x).to_date
  end
end
