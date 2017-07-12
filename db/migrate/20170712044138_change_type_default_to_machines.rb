# frozen_string_literal: true

class ChangeTypeDefaultToMachines < ActiveRecord::Migration[5.1]
  def up
    change_column :machines, :type, :integer, default: 0
  end
end
