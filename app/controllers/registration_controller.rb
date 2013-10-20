class RegistrationController < ApplicationController
  def register
  	@user = current_user
  	@user.skills.build
  end

  def update
  	@user = current_user
  	puts "HERE ARE THE LEARNING PARAMS"
  	puts learning_params
  	User.update(@user.id,learning_params)
  end

  def learning_params
  	params.require(:user).permit!
  end
end
