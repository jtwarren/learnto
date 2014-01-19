class LessonsController < ApplicationController

  def index
    if current_user != nil && current_user.admin
      @lessons = Lesson.all.order('updated_at DESC')
    else
      redirect_to root_path
    end
  end

  def create
    skill = Skill.find(params[:skill_id])
    if not current_user
      redirect_to skill, notice: "You must be logged in to sign up for a lesson."
    end
    lesson = skill.lessons.create(status: "PENDING")
    lesson.users << current_user

    conversation = Conversation.create()
    lesson.conversation = conversation

    message = conversation.messages.create(body: params[:learning_request], user: current_user)

    conversation.receipts.create(user_id: current_user.id, read: true)
    conversation.receipts.create(user_id: skill.user.id, read: false)

    lesson.conversation = conversation

    Notifier.lesson_request(skill.user, current_user, lesson).deliver

    redirect_to lesson_url(lesson)
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to @lesson, notice: 'Status was successfully updated.'
    end
  end

  def show
    if not current_user
      redirect_to login_url(return_to: lesson_path(@lesson))
      return
    end
    
    @lesson = Lesson.find(params[:id])

    if not @lesson.users.include?(current_user) and not @lesson.skill.user == current_user and not current_user.admin
      redirect_to skills_path, notice: 'You are not authorized to view this page.'
      return
    end

    @message = Message.new

    @review = Review.new

    # if current_user
    #   if current_user.admin || current_user.taken_lesson(@lesson) || current_user.taught_lesson(@lesson)
    #     receipt = @lesson.conversation.receipts.where(user_id: current_user.id).first
    #     if receipt
    #       receipt.update_attribute(:read, true)
    #       receipt.save!
    #     end
    
    #     # @other_user = @lesson.findOtherUser(current_user)
    #     addedReview = current_user.reviewFor(@other_user,@lesson)
    #     if addedReview
    #       @review = addedReview
    #     end
    #     if current_user == @lesson.user
    #       responses = @lesson.conversation.messages.where(sender: @other_user.id)
    #     end
    #   else
    #     redirect_to root_url
    #   end
    # else
    #   redirect_to  login_url(return_to: lesson_path(@lesson))
    # end
  end

  private
    def lesson_params
      params.require(:lesson).permit(:status)
    end

end
