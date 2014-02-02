class RequestsController < ApplicationController
  def index
    @requests = Request.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @request = Request.find(params[:id])
    # @lesson = nil
    # if current_user
    #   @lesson = current_user.taken_class(@skill)
    #   if @lesson
    #     @review = current_user.reviewFor(@skill.user, @lesson)
    #   end
    # end
    # if !@review
    #   @review = Review.new
    # end

    if current_user and session[:show_modal] and session[:request_id] == @request.id
      @show_modal = true
      session.delete(:show_modal)
      session.delete(:request_id)
    end

    if not current_user
      session[:show_modal] = true
      session[:request_id] = @request.id
    end

    @return_to = request.path

    respond_to do |format|
      format.html
    end
  end

  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      Notifier.request_added(@request).deliver
      redirect_to @request
    elsif @request.errors.any?
      # break
      @request.errors.full_messages.each do |msg|
        if !flash[:warning]
          flash[:warning] = msg + '. '
        else
          flash[:warning] += msg + '. '
        end
      end
      render 'new'
    else
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
