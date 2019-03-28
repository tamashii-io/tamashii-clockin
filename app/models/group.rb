# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :groupings
  has_many :users, through: :groupins
end
