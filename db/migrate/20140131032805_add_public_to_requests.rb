class AddPublicToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :public, :boolean, :default => false
  end
end
