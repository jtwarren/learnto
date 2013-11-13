class AddStarsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :stars, :integer
  end
end
