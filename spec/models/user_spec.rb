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

  describe '.from_omniauth' do
    def auth(hash = {})
      auth = { provider: 'gitlab',
               uid: '1234567890',
               info: {
                 email: 'test@test.com',
                 first_name: 'first',
                 last_name: 'last'
               } }.merge(hash)
      JSON.parse(auth.to_json, object_class: OpenStruct)
    end

    context 'existed user' do
      subject { create(:user, email: 'test@test.com', gitlab_id: nil) }

      it 'has authorized' do
        subject.update_attributes(gitlab_id: '1234567890')
        expect { User.from_omniauth(auth) }.to change { described_class.count }.by(0)
      end

      it 'has not authorized' do
        subject
        User.from_omniauth(auth)
        expect(subject.reload.gitlab_id).to eq('1234567890')
      end
    end

    it 'new user' do
      expect { User.from_omniauth(auth) }.to change { described_class.count }.by(1)
      user = User.last
      expect(user.email).to eq('test@test.com')
      expect(user.gitlab_id).to eq('1234567890')
    end
  end
end
