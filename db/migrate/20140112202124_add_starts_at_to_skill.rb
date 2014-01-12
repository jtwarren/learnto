class AddStartsAtToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :starts_at, :datetime
  end
end
