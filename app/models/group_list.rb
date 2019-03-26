# frozen_string_literal: true

class GroupList < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
