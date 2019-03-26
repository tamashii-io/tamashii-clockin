class AddGroupToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :group_id, :integer
  end
end
