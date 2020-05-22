class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invite_params)
    @invitation.attended_event_id = params[:event_id]
    event = Event.find_by(id: params[:event_id])
    user = User.find_by(id: params[:invitation][:attendee_id])

    event_attendees = event.attendees

    if user.nil?
      flash[:notice] = 'User Does Not Exist'
    elsif !event_attendees.include?(user)
      @invitation.save
    else
      flash[:notice] = 'User Already Invited'
    end
    redirect_to event_path(@invitation.attended_event_id)
  end

  private

  def invite_params
    params.require(:invitation).permit(:attendee_id)
  end
end
