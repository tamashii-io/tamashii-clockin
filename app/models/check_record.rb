# frozen_string_literal: true

class CheckRecord < ApplicationRecord
  MAX_CHECKIN_TIME = 5.seconds

  belongs_to :user
  self.inheritance_column = :_type_disabled

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }


  # def set_type
  # 	puts "aaa"
  # 	uesr_records = self.user.check_records
  # 	last_record = self.user.check_records[uesr_records.length-2].created_at
  # 	p last_record
  # 	p Time.at(last_record).to_date
  # 	if Time.at(last_record).to_date != Time.at(self.created_at).to_date
  # 		self.type = 1
  # 		puts "----1----"
  # 	else Time.at(last_record).to_date != Time.at(self.created_at).to_date

  # 	end
  #   self.type = 1
  #   save
  # end
  def set_type x
    self.type = x
    save
  end

end
