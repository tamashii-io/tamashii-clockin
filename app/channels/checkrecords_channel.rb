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
      broadcast_to('check_records_notify', type: EVENTS[:notify])
      broadcast_to('check_records_set', type: EVENTS[:set], check_record: record.as_json)
    end
  end

  def follow(data)
    stop_all_streams
    return stream_for 'check_records_set' if page_one? data['page']
    stream_for 'check_records_notify'
  end

  def unfollow
    stop_all_streams
  end

  private

  def page_one?(page_num)
    page_num.empty? || page_num == '1'
  end
end
