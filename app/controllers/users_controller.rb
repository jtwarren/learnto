class UsersController < ApplicationController

  def new
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      url = session[:return_to] || skills_url
      session[:return_to] = nil
      url = skills_url if url.eql?('/logout')
      redirect_to url
    else
      render action: 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @skills = @user.skills.where(approved: true)
    @pending_skills=[]
    if @user == current_user
      @pending_skills = @user.skills.where(approved: false)
      @requested_lessons=[]
      @scheduled_lessons=[]
      @skills.each do |skill|
        requests = skill.lessons.where("ignored=? AND approved=?", false, false)
        scheduled = skill.lessons.where("ignored=? AND approved=? AND completed=?", false, true, false)
        @requested_lessons.push(*requests)
        @scheduled_lessons.push(*scheduled)
      end
    end
  end

  def requests
    @user = User.find(params[:id])
    @lessons = @user.lessons.where("approved=? AND completed=?", true, true)
    if @user == current_user
      @pending_lessons = @user.lessons.where("ignored=? AND approved=?", false, false)
      @incomplete_lessons = @user.lessons.where("approved=? AND completed=?", true, false)
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  def sign_in
  end

  def update
    @user = @current_user
  end

  def inquire
    if params[:skill_id]
      skill = Skill.find(params[:skill_id])
      message = Message.create(body: params[:request], sender: current_user.id, receiver:skill.user.id)
      lesson = skill.lessons.new(:learning_request=>params[:request])
      # c=Conversation.create()
      # c.messages << message
      # c.receipts.create(user_id: current_user.id, read: true)
      # c.receipts.create(user_id: skill.teacher.id, read: false)
      # lesson.conversation = c
    else
      lesson = Lesson.new(:learning_request=>params[:request])
    end
    current_user.lessons << lesson
    if lesson.save
      if params[:skill_id]
        redirect_to skill_url(params[:skill_id], :confirm => true)
      else
        redirect_to skills_url, notice: "Your request has been submitted. Thanks for using Learnto!"
      end
    else
      redirect_to skills_url, error: 'There was an error processing your request.'
    end
  end

  private
    def user_params
      params.require(:regular_user).permit(:first_name, :last_name, :picture, :email, :password, :password_confirmation)
    end
end
