class UsersController < ApplicationController

  def new
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to register_url
    else
      render action: 'new'
    end
  end

  def show
    @approved_skills = User.find(params[:id]).skills
    @pending_skills = User.find(params[:id]).skills.pending
  end

  def edit
    @user = User.find(params[:id])
  end

  def sign_in
  end

  def update
    @user = @current_user
  end

  def inquire
    if params[:skill_id]
      lesson = Skill.find(params[:skill_id]).lessons.new(:learning_request=>params[:request])
    else
      lesson=Lesson.new(:learning_request=>params[:request])
    end
    current_user.lessons << lesson
    if lesson.save
      if params[:skill_id]
        redirect_to skill_url(params[:skill_id], :confirm=>true)
      else
        redirect_to skills_url, notice: "Your request has been submitted. Thanks for using Learnto!"
      end
    else
      redirect_to skills_url, error: 'There was an error processing your request.'
    end
  end

  private
    def user_params
      params.require(:regular_user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
