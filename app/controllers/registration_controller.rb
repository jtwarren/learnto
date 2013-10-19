class RegistrationController < ApplicationController
  def register
  	@user = current_user
  	@user.skills.build
  end

  def update
  	@user = current_user
  	newParams=learning_params
  	puts newParams
  	User.update(@user.id,learning_params)
  end

  def learning_params
  	params.require(:user).permit(:learning_request, :skills_attributes => [:id, :title, :qualifications])
  end
end
