class ReviewsController < ApplicationController

  def create
    review = Review.create(message: review_params['message'], lesson_id: review_params['lesson_id'], target_user_id: review_params['target_user_id'], stars: review_params['stars'])
    review.user=current_user
    review.save!
    if review_params['source_url']
      redirect_to review_params['source_url']
    else
      redirect_to skill_url(review.lesson.skill)
    end
  end

  def review_params
    params.require(:review).permit(:message, :lesson_id, :target_user_id, :stars, :source_url)
  end

end
