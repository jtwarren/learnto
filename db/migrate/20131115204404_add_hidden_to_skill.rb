class AddHiddenToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :hidden, :boolean, default: false 
  end
end
