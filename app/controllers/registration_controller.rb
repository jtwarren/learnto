class RegistrationController < ApplicationController
  def register
    if @user
      @user = current_user
  	  @user.skills.build
    else
      redirect_to home_url
  end

  def update
  	@user = current_user
  	User.update(@user.id, learning_params)
  	redirect_to skills_path
  end

  def learning_params
    params.require(:user).permit!
  end
end
