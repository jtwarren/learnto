class ReviewsController < ApplicationController

  def create
    puts (review_params)
    puts "LOOK UP"
    review = Review.create(review_params)
    review.user=current_user
    review.stars=5
    review.save!
    redirect_to skill_url(review.lesson.skill)
  end

  def review_params
    params.require(:review).permit(:message, :lesson_id)
  end

end
