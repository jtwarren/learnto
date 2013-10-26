class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :force_www!

  protected

  def force_www!
    if Rails.env.production? and request.host[0..3] != "www."
      redirect_to "#{request.protocol}www.#{request.host_with_port}#{request.fullpath}", :status => 301
    end
  end


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
