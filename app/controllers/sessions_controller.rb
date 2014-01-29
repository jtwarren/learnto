class SessionsController < ApplicationController

  def new
    @return_to = params[:return_to]
    @facebook_param_string = params[:return_to] ? "?return_to=" + params[:return_to] : ""
  end

  def create
    @facebook_param_string = params[:return_to] ? "?return_to=" + params[:return_to] : ""
    if request.env["omniauth.auth"].present?
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id

      if oauth.new_user == true
        session[:new_user] = true
      end

      url = env["omniauth.params"]["return_to"]
      if current_user.networks.size > 0
        url ||= networks_url(id:current_user.networks.first.id)
      else
        url ||= skills_url
      end
      return redirect_to url
    else
      user = RegularUser.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id

        url = params[:return_to]
        
        if user.networks.size > 0
          puts "-------------------------------------"
          url ||= networks_url(id: user.networks.first.id)
        else
          url ||= skills_url
        end
        return redirect_to url
      else
        render action: 'new'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end