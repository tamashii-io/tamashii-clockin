# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many :check_records }
  end

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

  describe 'check_records' do
    it 'clockin_1' do
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockin')
    end

    it 'clockout' do
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockout')
    end

    it 'clockin_2' do
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockin')
    end

    it 'clockout_2' do
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockout')
    end

    it 'next day clockin' do
      subject.checkin
      Timecop.travel(1.day)
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockin')
    end

    it 'next day clockout' do
      subject.checkin
      Timecop.travel(1.day)
      subject.checkin
      Timecop.travel(5.minutes)
      subject.checkin
      expect(subject.check_records.first.behavior).to eq('clockout')
    end
  end
end
