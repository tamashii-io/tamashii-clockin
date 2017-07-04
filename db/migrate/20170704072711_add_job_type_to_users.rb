# frozen_string_literal: true

class AddJobTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :job_type, :integer, default: 0
  end
end
