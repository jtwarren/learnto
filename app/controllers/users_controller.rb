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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = @current_user
  end

  def inquire
    lesson = Skill.find(params[:skill_id]).lessons.new(:learning_request=>params[:request])
    current_user.lessons << lesson
    if lesson.save
      redirect_to skills_url, notice: 'Successfully saved your information.'
    else
      redirect_to skills_url, error: 'There was an error processing your request.'
    end
  end

  private
    def user_params
      params.require(:regular_user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
