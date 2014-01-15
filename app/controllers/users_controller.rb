class UsersController < ApplicationController

  def new
    @user = RegularUser.new
    @return_to = params[:return_to]
    @facebook_param_string = params[:return_to] ? "?return_to=" + params[:return_to] : ""
  end

  def create
    @facebook_param_string = params[:return_to] ? "?return_to=" + params[:return_to] : ""
    @user = RegularUser.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      url = params[:return_to]
      url ||= user_url(@user)
      redirect_to url
    elsif @user.errors.any?
      @user.errors.full_messages.each do |msg|
        if !flash[:warning]
          flash[:warning] = msg + '. '
        else
          flash[:warning] += msg + '. '
        end
      end
      redirect_to signup_url
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])

    if not current_user or current_user.id != @user.id
      redirect_to @user, notice: 'You are not authorized to edit this profile.'
    end
    
  end

  def show
    @user = User.find(params[:id])
    @skills = @user.skills.where("approved = ? AND hidden = ?", true, false)
    # @pending_skills = []
    # if @user == current_user
    #   @pending_skills = @user.skills.where(approved: false)
    #   # @requested_lessons = []
    #   # @scheduled_lessons = []
    #   # @skills.each do |skill|
    #   #   requests = skill.lessons.where("ignored=? AND approved=?", false, false)
    #   #   scheduled = skill.lessons.where("ignored=? AND approved=? AND completed=?", false, true, false)
    #   #   @requested_lessons.push(*requests)
    #   #   @scheduled_lessons.push(*scheduled)
    #   # end
    # end
  end

  # def requests
  #   @user = User.find(params[:id])
  #   @lessons = @user.lessons.where("approved=? AND completed=?", true, true)
  #   if @user == current_user
  #     @pending_lessons = @user.lessons.where("ignored=? AND approved=?", false, false)
  #     @incomplete_lessons = @user.lessons.where("approved=? AND completed=?", true, false)
  #   end
  # end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def user_params
      params.require(:regular_user).permit(:first_name, :last_name, :picture, :email, :password, :password_confirmation, :bio, :work, :school)
    end

    def update_user_params
      params.require(:user).permit(:first_name, :last_name, :picture, :email, :password, :password_confirmation, :bio, :work, :school, :location)
    end      
end
