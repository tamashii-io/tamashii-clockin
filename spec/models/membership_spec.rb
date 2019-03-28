# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'Association' do
    it { should belong_to :user }
    it { should belong_to :group }
  end

  subject { create(:membership) }

  describe 'create membership' do
    it { expect(subject.user_id).to be_kind_of(Integer) }
    it { expect(subject.group_id).to be_kind_of(Integer) }
  end
end
