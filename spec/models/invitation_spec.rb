require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:attendee_id) }
  end
  describe 'associations' do
    it { should belong_to(:attendee).class_name('User') }
    it { should belong_to(:attended_event).class_name('Event') }
  end
end
