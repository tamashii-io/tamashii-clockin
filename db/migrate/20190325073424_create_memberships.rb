class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.string :title
      t.date :join_time

      t.timestamps
    end
  end
end
