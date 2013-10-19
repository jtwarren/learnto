class RegistrationController < ApplicationController
  def register
  	@user = current_user
  	end
end
