class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gitlab_id, :string
  end
end
