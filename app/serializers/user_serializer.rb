# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :email, :card_serial
  attribute :links do
    {
      edit: edit_users_admin_path(object),
      self: users_admin_path(object)
    }
  end

  attribute :job_type do
    I18n.t("user.job_type.#{object.job_type}")
  end
end
