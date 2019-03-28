# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :title

      t.timestamps
    end
  end
end
