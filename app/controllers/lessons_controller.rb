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
    lesson = skill.lessons.create(params[:lesson].permit(:learning_request))
    lesson.update(user: current_user)
    message = Message.create(body: params[:lesson][:learning_request], sender: current_user.id, receiver: skill.user.id)
    c = Conversation.create()
    c.messages << message
    c.receipts.create(user_id: current_user.id, read: true)
    c.receipts.create(user_id: skill.user.id, read: false)
    lesson.conversation = c
    t = lesson.tokens.create(user_id: current_user.id)
    current_user.tokens << t
    Notifier.lesson_request(skill.user, current_user, lesson).deliver
    redirect_to lesson_url(lesson)
  end

  def show
    @lesson = Lesson.find(params[:id])
    @review = Review.new
    if current_user
      if  current_user.admin || current_user.taken_lesson(@lesson) || current_user.taught_lesson(@lesson)
        receipt = @lesson.conversation.receipts.where(user_id: current_user.id).first
        if receipt
          receipt.update_attribute(:read, true)
          receipt.save!
        end
        @message = Message.new
        @other_user = @lesson.findOtherUser(current_user)
        addedReview = current_user.reviewFor(@other_user,@lesson)
        if addedReview
          @review = addedReview
        end
        if current_user == @lesson.user
          responses = @lesson.conversation.messages.where(sender: @other_user.id)
          token = @lesson.findToken(current_user)
          if !token.paid && responses.size > 0
            if current_user.credits > 0
              token.acceptCredit(current_user)
            else
              flash[:warning] = "You don't have enough credits to view the response and reply. Please sign up to teach or approve a pending lesson to earn credits!"
              if current_user.skills.empty?
                redirect_to create_skill_url
              else
                redirect_to inbox_conversations_path
              end
            end
          end
        end
      else
        redirect_to root_url
      end
    else
      redirect_to  login_url(return_to: lesson_path(@lesson))
    end
  end

  def approve
    lesson = Lesson.find(params[:id])
    if current_user == lesson.teacher
      lesson.update_attribute(:approved, true)
      current_user.credits += 1
      current_user.save!
      flash[:notice] = "Congratulations! You just earned another credit! Use it by signing up for a lesson!"
    end
    redirect_to lesson_path(lesson)
  end

  def ignore
   lesson = Lesson.find(params[:id])
    if current_user == lesson.teacher
     lesson.ignore
    end
    redirect_to lesson_path(lesson)
  end

  def complete
   lesson = Lesson.find(params[:id])
    if current_user == lesson.teacher
     lesson.complete
    end
    redirect_to lesson_path(lesson)
  end

end
