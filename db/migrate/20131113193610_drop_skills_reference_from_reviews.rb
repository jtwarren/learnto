class DropSkillsReferenceFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :skill_id
  end
end
