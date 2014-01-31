class RequestsController < ApplicationController
  def index
    @requests = Request.where("approved = ? AND hidden = ?", true, false)
    respond_to do |format|
      format.html
    end
  end

  def show
    @request = Request.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      Notifier.request_added(@request).deliver
      redirect_to @request
    else
      puts '----------------------------------'
      puts request_params
      render 'new'
    end
  end

  def new
    if not current_user
      redirect_to login_url(return_to: request.path)
      return
    end
    @request = Request.new
  end

  def edit
    @request = current_user.requests.find(params[:id])
  end

  def remove
    @request = current_user.requests.find(params[:id])
    @request.hidden = true
    @request.save!
    flash[:warning] = "Request removed"
    redirect_to root_url
  end

  def update
    @request = current_user.requests.find(params[:id])
    if @request.update(request_params)
      redirect_to @request, notice: "Request was successfully updated"
    else
      render 'edit'
    end
  end

  private
    def request_params
      params.require(:request).permit(:title, :description, :picture, :public)
    end
end
