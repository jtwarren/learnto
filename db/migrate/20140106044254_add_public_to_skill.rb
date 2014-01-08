class AddPublicToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :public, :boolean, :default => true
  end
end
