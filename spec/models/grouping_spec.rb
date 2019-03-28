# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Grouping, type: :model do
  describe 'Association' do
    it { should belong_to :user}
    it { should belong_to :group}
  end
end
