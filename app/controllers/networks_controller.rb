class NetworksController < ApplicationController
  def show
    @network = Network.find(params[:id])
  end

  def join
    @network = Network.find(params[:id])
    @network.users << current_user
  end
end
