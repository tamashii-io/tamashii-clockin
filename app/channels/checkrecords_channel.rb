# frozen_string_literal: true
# missing top-level class documentation comment
class CheckrecordsChannel < ApplicationCable::Channel
  EVENTS = {
    set: 'CHECK_RECORD_SET'
  }.freeze

  class << self
    def set(check_record)
      broadcast_to("check_records_page", type: EVENTS[:set], check_record: check_record.to_json)
    end
  end

  def follow(data)
    stop_all_streams
    stream_for "check_records_page"
  end

  def unfollow
    stop_all_streams
  end
end
