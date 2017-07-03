# frozen_string_literal: true

class ChangeAdminAndCardSerialDefaultToUsers < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :admin, :boolean, default: false
    change_column :users, :card_serial, :string, default: ''
  end
end
