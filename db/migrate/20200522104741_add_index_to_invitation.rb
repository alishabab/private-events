class AddIndexToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_index :invitations, :attended_event_id
    add_index :invitations, :attendee_id
    add_index :events, :creator_id
  end
end
