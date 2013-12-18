class ReviewsController < ApplicationController

  def create
    review = Review.create(review_params)
    review.user=current_user
    review.save!
    if URI(request.referer).path
      redirect_to URI(request.referer).path
    else
      redirect_to skill_url(review.lesson.skill)
    end
  end

  def review_params
    params.require(:review).permit(:message, :lesson_id, :target_user_id, :stars)
  end

end
