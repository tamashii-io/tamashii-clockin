# frozen_string_literal: true

class CreateCheckRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :check_records do |t|
      t.integer :user_id
      t.integer :type

      t.timestamps
    end
  end
end
