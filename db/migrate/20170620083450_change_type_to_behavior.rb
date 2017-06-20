# frozen_string_literal: true

class ChangeTypeToBehavior < ActiveRecord::Migration[5.1]
  def change
    rename_column :check_records, :type, :behavior
  end
end
