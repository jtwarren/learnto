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
    redirect_to skill_url(skill)

    message = Message.create(body: params[:lesson][:learning_request], sender: current_user.id, receiver: skill.user.id)

    c = Conversation.create()
    c.messages << message
    c.receipts.create(user_id: current_user.id, read: true)
    c.receipts.create(user_id: skill.user.id, read: false)
    lesson.conversation = c
    Notifier.lesson_request(skill.user, current_user, lesson).deliver
  end

  def show
    @lesson = Lesson.find(params[:id])
    if current_user
      if  current_user.admin || current_user.taken_lesson(@lesson) || current_user.taught_lesson(@lesson)
        receipt = @lesson.conversation.receipts.where(user_id: current_user.id).first
        if receipt
          receipt.update_attribute(:read, true)
          receipt.save!
        end
        @message = Message.new
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
      lesson.approve
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
