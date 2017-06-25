# frozen_string_literal: true
# Attendee Serializer
class CheckRecordSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id, :behavior, :created_at, :updated_at
  attribute :user do
    {
      name: object.user.name
    }
  end
end
