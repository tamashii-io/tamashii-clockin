# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :group_lists
  has_many :users, through: :group_lists
end
