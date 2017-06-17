# frozen_string_literal: true

class CheckRecordsController < ApplicationController
  def index
    @checkrecords = CheckRecord.all
  end
end
