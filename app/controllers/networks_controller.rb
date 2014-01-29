class NetworksController < ApplicationController
  def show
    # if not current_user
    #   return redirect_to skills_url, notice: "Please log in to view lessons within your networks."
    # end
    @network = Network.find(params[:id])
    session[:default_network] = @network.id
    @user = current_user
    @show_banner = true
    @events = @network.events
    if session[:new_user]
      @show_user_bio = true
      session.delete(:new_user)
    end
    render 'skills/index'
  end
end