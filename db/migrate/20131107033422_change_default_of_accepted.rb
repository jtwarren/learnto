class ChangeDefaultOfAccepted < ActiveRecord::Migration
  def change
    change_column :lessons, :approved, :boolean, :default=> false
  end
end
