class UsersController < ApplicationController

  def new
    @user = RegularUser.new
  end


  def create
    @user = RegularUser.new(params[:regular_user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to register_url
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = @current_user
  end
end
