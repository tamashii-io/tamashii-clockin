# frozen_string_literal: true

# Machine Serializer
class MachineSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :serial, :name, :type
  attribute :links do
    {
      edit: edit_machine_path(object),
      self: machine_path(object),
      command: machine_actions_path(object)
    }
  end

  attribute :registrar do
    object.registrar.nil? ? '' : object.registrar.name
  end
end
