# frozen_string_literal: true

class CheckRecord < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  belongs_to :user
  self.inheritance_column = :_type_disabled

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }

  def assign_type(x)
    self.type = x
    save
  end
end
