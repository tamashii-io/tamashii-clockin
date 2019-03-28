# frozen_string_literal: true

class RenameTableGroupListToGrouping < ActiveRecord::Migration[5.1]
  def change
    rename_table('group_lists', 'groupings')
  end
end
