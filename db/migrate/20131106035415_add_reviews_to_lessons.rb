class AddReviewsToLessons < ActiveRecord::Migration
  def change
    add_reference :lessons, index: true
  end
end
