class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  force_ssl if: :ssl_configured?

  # before_filter :require_network


  def ssl_configured?
    # !Rails.env.development?
    false
  end

  def require_network
    if not current_network
      return redirect_to root_url
    end
  end



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_network
    @current_network ||= Network.find_by(subdomain: request.subdomain)
  end

  helper_method :current_user, :current_network
end
