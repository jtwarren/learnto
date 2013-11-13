class SessionsController < ApplicationController

  def new
    @return_to = params[:return_to]
    @param_string = params[:return_to] ? "?return_to=" + params[:return_to] : ""
  end

  def create
    if request.env["omniauth.auth"].present?
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id

      url = env["omniauth.params"]["return_to"]
      url ||= skills_url
      redirect_to url
    else
      user = RegularUser.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id

        url = params[:return_to]
        url ||= skills_url
        redirect_to url
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