# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :memebrships
  has_many :users, through: :memebrships
end
