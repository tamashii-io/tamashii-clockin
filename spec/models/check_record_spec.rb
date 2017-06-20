# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckRecord, type: :model do
  it { should belong_to(:user) }

  subject { create(:check_record) }

  describe '.active' do
    it 'not exceed the time limit' do
      expect(CheckRecord.active).to include(subject)
    end

    it 'exceed the time limit' do
      subject.update_attributes(updated_at: 5.days.ago)
      expect(CheckRecord.active).not_to include(subject)
    end
  end

end
