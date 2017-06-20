# frozen_string_literal: true

class CheckRecord < ApplicationRecord
  MAX_CHECKIN_TIME = 5.seconds

  belongs_to :user
  before_save :assign

  self.inheritance_column = :_type_disabled

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  def assign
    return self.type = 0 if (user.check_records.today.count % 2).zero?
    self.type = 1
  end
end
