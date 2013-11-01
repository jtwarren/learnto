class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env["omniauth.auth"].present?
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      if env["omniauth.params"]["request"] == nil      
        if oauth.new_user or (env["omniauth.params"]["action"] =="update skills")
          redirect_to register_url
        else
          redirect_to skills_url
        end
      else
        redirect_to user_inquire_url(:request=> env["omniauth.params"]["request"], :skill_id=>env["omniauth.params"]["skill_id"])
      end
    else
      user = RegularUser.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to skills_url
      else
        flash.now[:error] = "Invalid login credentials."
        render action: 'new'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end