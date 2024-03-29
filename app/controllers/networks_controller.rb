class NetworksController < ApplicationController
  def show
    # if not current_user
    #   return redirect_to skills_url, notice: "Please log in to view lessons within your networks."
    # end
    @network = Network.find_by(subdomain: request.subdomain)
    if !@network and params[:id]
      @network = Network.find(params[:id])
    end
    session[:default_network] = @network.id
    @user = current_user
    @show_banner = false
    @events = @network.events
    if session[:new_user]
      @show_user_bio = true
      session.delete(:new_user)
    end
    render 'skills/index'
  end
end