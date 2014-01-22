class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @return_to = request.path

    if current_user and session[:show_modal] and session[:event_id] == @event.id
      @show_modal = true
      session.delete(:show_modal)
    end

    if not current_user
      session[:show_modal] = true
      session[:event_id] = @event.id
    end
  end

  def new
    if not current_user
      redirect_to login_url(return_to: request.path)
      return
    end
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
      if @event.students.include? current_user
        redirect_to @event, notice: 'You are already signed up.'
        return
      else
        @event.students << current_user
        if @event.capacity && (@event.students.count > @event.capacity)
          redirect_to @event, notice: 'You have been added to the waitlist.'
          return
        else
          redirect_to @event, notice: 'You are successfully enrolled.'
          return
        end
      end
    else
      redirect_to @event, notice: 'You must be logged in to attend.'
      return
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :qualifications, :picture, :starts_at, :address, :capacity)
    end
end
