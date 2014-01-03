class RemoveCreditsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :credits, :integer
  end
end
