class MakeReviewReferenceLesson < ActiveRecord::Migration
  def change
    add_reference :reviews, :lesson, index: true
  end
end
