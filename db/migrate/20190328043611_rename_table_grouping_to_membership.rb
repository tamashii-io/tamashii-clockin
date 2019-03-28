# frozen_string_literal: true

class RenameTableGroupingToMembership < ActiveRecord::Migration[5.1]
  def change
    rename_table('groupings', 'memberships')
  end
end
