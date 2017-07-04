# frozen_string_literal: true

class AddDeletedToCheckRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :check_records, :deleted, :boolean, default: false
  end
end
