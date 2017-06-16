class CheckRecordsController < ApplicationController
  def index
    @checkrecords = CheckRecord.all
  end
end
