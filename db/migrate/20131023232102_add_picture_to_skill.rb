class AddPictureToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :picture, :string
  end
end
