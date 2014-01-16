class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @return_to = request.path
  end

  def new
    @event = Event.new
    @event.starts_at = 7.days.since(Time.now)
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      Notifier.event_added(@event).deliver
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Skill was successfully updated.'
    else
      render 'edit'
    end
  end

  def attend
    @event = Event.find(params[:id])
    if current_user
      @event.students << current_user
      redirect_to @event, notice: 'You are successfully enrolled.'
    else
      redirect_to @event, notice: 'You must be logged in to attend.'
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :picture, :starts_at, :location)
    end
end