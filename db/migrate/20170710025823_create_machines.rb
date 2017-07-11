# frozen_string_literal: true

class CreateMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :machines do |t|
      t.string :serial
      t.string :name

      t.timestamps
    end
  end
end
