class RegistrationController < ApplicationController
  def register
  	@user = current_user
  	@user.skills.build
  end

  def update
  	@user = current_user
  	User.update(@user.id, learning_params)
  end

  def learning_params
    params.require(:user).permit!
  end
end
