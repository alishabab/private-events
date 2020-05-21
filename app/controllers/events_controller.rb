# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.all
    @past = Event.all.past
    @future = Event.all.future
  end

  def new
    @current_user = User.find_by_id(session[:current_user_id])
    @event = @current_user.created_events.build
  end

  def show
    @event = Event.find_by_id(params[:id])
  end

  def create
    @current_user = User.find_by_id(session[:current_user_id])
    @event = @current_user.created_events.build(event_params)
    redirect_to @event if @event.save
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end
end
