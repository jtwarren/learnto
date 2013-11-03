class AddApprovedToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :approved, :boolean, default: false
  end
end
