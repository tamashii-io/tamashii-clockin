# frozen_string_literal: true

FactoryBot.define do
  factory :membership, class: Membership do
    user_id { 1 }
    group_id { 1 }

    association :user, factory: :user
    association :group, factory: :group
  end
end
