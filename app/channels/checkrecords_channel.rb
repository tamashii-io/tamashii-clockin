# frozen_string_literal: true

# missing top-level class documentation comment
class CheckrecordsChannel < ApplicationCable::Channel
  EVENTS = {
    set: 'CHECK_RECORD_SET',
    notify: 'NOTIFY_NEW_RECORD'
  }.freeze

  class << self
    def set(check_record)
      record = CheckRecordSerializer.new(check_record)
      Rails.logger.debug record
      broadcast_to('check_records_page', type: EVENTS[:notify])
      broadcast_to('check_records_page', type: EVENTS[:set], check_record: record.as_json)
    end
  end

  def follow
    stop_all_streams
    stream_for 'check_records_page'
  end

  def unfollow
    stop_all_streams
  end
end
