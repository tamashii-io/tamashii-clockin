# frozen_string_literal: true

class Grouping < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
