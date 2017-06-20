# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:check_records) }

  subject { create(:user) }

  describe '#checkin' do
    it 'no check_record' do
      expect { subject.checkin }.to change { CheckRecord.count }.by(1)
    end

    it 'has check_record exclude -INFINITY..specific.ago' do
      subject.checkin
      expect { subject.checkin }.to change { CheckRecord.count }.by(0)
    end
  end
end
