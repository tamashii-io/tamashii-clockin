# frozen_string_literal: true

class CheckRecordsController < ApplicationController
  def index
    # @checkrecord = CheckRecord.last
    @checkrecords = CheckRecord.active_records

    respond_to do |format|
      format.html
      format.json { render json: @checkrecords }
    end
  end
end
