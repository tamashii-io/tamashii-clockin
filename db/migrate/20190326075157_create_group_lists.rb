# frozen_string_literal: true

class CreateGroupLists < ActiveRecord::Migration[5.1]
  def change
    create_table :group_lists do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
