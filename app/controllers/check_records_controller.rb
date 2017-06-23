# frozen_string_literal: true

class CheckRecordsController < ApplicationController
  def index
    @checkrecords = CheckRecord.all

    respond_to do |format|
      format.html
      format.json { render json: @checkrecords }
    end
  end
end
