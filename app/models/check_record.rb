# frozen_string_literal: true

class CheckRecord < ApplicationRecord
  paginates_per 5
  # TODO: modify for test
  MAX_CHECKIN_TIME = 5.seconds
  default_scope { order(created_at: :desc) }

  belongs_to :user
  before_save :assign
  after_save do
    CheckrecordsChannel.set(self)
  end

  enum behavior: {
    clockin: 0,
    clockout: 1
  }

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :this_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :active_records, -> { where(deleted: false) }

  def self.daily_activity
    unscope(:order).group_by_hour_of_day(:created_at)
  end

  def self.monthly_activity
    unscope(:order).group_by_day_of_month(:created_at)
  end

  def to_json
    rtn = as_json
    rtn['user'] = user
    rtn
  end

  private

  def assign
    return self.behavior = :clockin if (user.check_records.today.count % 2).zero?
    self.behavior = :clockout
  end
end
