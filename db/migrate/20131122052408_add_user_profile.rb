class AddUserProfile < ActiveRecord::Migration
  def change
    add_column :users, :learn, :text
    add_column :users, :interest, :text
  end
end
