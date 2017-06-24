# frozen_string_literal: true
# missing top-level class documentation comment
class CheckrecordsChannel < ApplicationCable::Channel
  EVENTS = {
    update: 'CHECK_RECORD_UPDATE',
    set: 'CHECK_RECORD_SET'
  }.freeze

  class << self
    def set(check_record)
      broadcast_to("aaa", type: EVENTS[:set], check_record: check_record.to_json)
    end
  end

  def follow(data)
    puts "~~follow"
    stop_all_streams
    stream_for "aaa"
  end

  def unfollow
    stop_all_streams
  end
end
