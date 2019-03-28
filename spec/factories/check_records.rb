# frozen_string_literal: true

FactoryBot.define do
  factory :check_record do
    user_id { 1 }
    association :user, factory: :user
  end
end
