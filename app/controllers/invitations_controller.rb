# frozen_string_literal: true

class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invite_params)
    @invitation.attended_event_id = params[:event_id]
    @user_id = params[:attendee_id]
    @user = User.find_by(id: @user_id)
    @event_attendees = @invitation.attendees

    if @event_attendees.include?(@user)
      flash.now[:notice] = 'User does not Exist'
      render :new

    else
      redirect_to event_path(@invitation.attended_event_id)
    end

    @invitation.save
    redirect_to event_path(@invitation.attended_event_id)
  end

  private

  def invite_params
    params.require(:invitation).permit(:attendee_id)
  end
end
