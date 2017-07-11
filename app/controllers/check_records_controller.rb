# frozen_string_literal: true

class CheckRecordsController < ApplicationController
  def index
    # @checkrecord = CheckRecord.last
    @checkrecords = CheckRecord.includes(:user).active_records.page params[:page]
    @page = params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @checkrecords }
    end
  end
end
