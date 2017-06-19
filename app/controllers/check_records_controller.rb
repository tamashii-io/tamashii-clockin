# frozen_string_literal: true

class CheckRecordsController < ApplicationController
  def index
    @checkrecords = CheckRecord.all.order(:created_at).reverse_order
  end
end
