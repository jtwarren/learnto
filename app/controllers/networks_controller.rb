class NetworksController < ApplicationController
  def show
    if not current_user
      return redirect_to skills_url, notice: "Please log in to view lessons within your networks."
    end
    @network = current_user.networks.find(params[:id])
    @user = current_user
    @show_banner = true
    @events = []
    render 'skills/index'
  end
end