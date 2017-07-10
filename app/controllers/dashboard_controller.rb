# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @daily_activity = CheckRecord.today.daily_activity
    @monthly_activity = CheckRecord.this_month.monthly_activity
  end
end
