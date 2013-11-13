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

  def update
    @user = @current_user
  end

  private
    def user_params
      params.require(:regular_user).permit(:first_name, :last_name, :picture, :email, :password, :password_confirmation)
    end
end
