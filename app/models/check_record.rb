# frozen_string_literal: true

class CheckRecord < ApplicationRecord
  # TODO: modify for test
  MAX_CHECKIN_TIME = 5.seconds
  default_scope { order(created_at: :desc) }

  belongs_to :user
  before_save :assign

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  private

  def assign
    return self.behavior = 0 if (user.check_records.today.count % 2).zero?
    self.behavior = 1
  end
end
