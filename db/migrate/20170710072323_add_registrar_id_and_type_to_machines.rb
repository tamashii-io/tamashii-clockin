# frozen_string_literal: true

class AddRegistrarIdAndTypeToMachines < ActiveRecord::Migration[5.1]
  def change
    add_column :machines, :type, :integer
    add_column :machines, :registrar_id, :integer
  end
end
