class AddTargetUserToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :target_user_id, :integer
  end
end
