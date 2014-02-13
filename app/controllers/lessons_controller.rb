class LessonsController < ApplicationController

  def index
    if current_user != nil && current_user.admin
      @lessons = Lesson.all.order('updated_at DESC')
    else
      return redirect_to root_path
    end
  end

  def create
    return_to = request
    lesson = nil
    receivers = []
    type = nil
    if not current_user
      return redirect_to return_to, notice: "You must be logged in."
    end

    if (params[:skill_id])
      skill = Skill.find(params[:skill_id])
      return_to = skill
      lesson = skill.lessons.create(status: "PENDING")
      receivers = [skill.user]
      type = 'REQUEST'
    elsif (params[:request_id])
      request = Request.find(params[:request_id])
      request.teacher = current_user.id
      request.save!
      return_to = request
      lesson = request.lessons.create(status: "APPROVED")

      lesson.users << request.users
      receivers = request.users
      type = 'OFFER'
    end

    if !lesson.users.include? current_user
      lesson.users << current_user
    end

    conversation = Conversation.create()
    lesson.conversation = conversation

    message = conversation.messages.create(body: params[:learning_request], user: current_user)

    conversation.receipts.create(user_id: current_user.id, read: true)

    receivers.each do |receiver|
      conversation.receipts.create(user_id: receiver.id, read: false)
    end

    lesson.conversation = conversation

    if type == 'REQUEST'
      Notifier.lesson_request(receivers.first, current_user, lesson).deliver
    
    elsif type =='OFFER'
      Notifier.lesson_offer(receivers, current_user, lesson).deliver
    end

    redirect_to lesson_url(lesson)
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      return redirect_to @lesson, notice: 'Status was successfully updated.'
    end
  end

  def add_student
    @lesson = Lesson.find(params[:id])
    if current_user
      if !current_user.lessons.include? @lesson
        current_user.lessons << @lesson
      end
      return redirect_to @lesson, notice: 'You are now a part of this lesson'
    else
      redirect_to @lesson
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    if not current_user
      return redirect_to login_url(return_to: lesson_path(@lesson))
    end
    

    # if not @lesson.users.include?(current_user) and not @lesson.skill.user == current_user and not current_user.admin
    #   return redirect_to skills_path, notice: 'You are not authorized to view this page.'
    # end
    @parent = nil
    @teacher = nil
    if @lesson.skill
      @parent = @lesson.skill
      @teacher = @lesson.skill.user
    end
    if @lesson.request
      @parent = @lesson.request
      @teacher = User.find(@lesson.request.teacher)
    end
    @message = Message.new
    @review = Review.new

    @show_review_form = ! @lesson.reviews.map(&:user).include?(current_user)

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
