class EventsController < ApplicationController
  skip_before_action :authorized, only: %i[index show]
  def index
    @current_user = current_user
    @events = Event.all
    @past = Event.all.past
    @future = Event.all.future
  end

  def new
    @current_user = current_user
    @event = @current_user.created_events.build
  end

  def show
    @current_user = current_user
    @event = Event.find_by_id(params[:id])
    @invitation = Invitation.new
  end

  def create
    @current_user = current_user
    @event = @current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event
    else
      flash.now[:alert] = @event.errors.full_messages
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description)
  end
end
