class AddDescriptionToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :description, :text
  end
end
