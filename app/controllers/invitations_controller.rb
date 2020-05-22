class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invite_params)
    @invitation.attended_event_id = params[:event_id]

    @invitation.save

    redirect_to event_path(@invitation.attended_event_id)
  end

  private 
  def invite_params
    params.require(:invitation).permit(:attendee_id)
  end

end
