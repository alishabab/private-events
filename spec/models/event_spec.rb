require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
  end
  describe 'associations' do
    it { should have_many(:invitations).with_foreign_key(:attended_event_id) }
    it { should have_many(:attendees).through(:invitations) }
    it { should belong_to(:creator).class_name('User') }
  end

  describe '::events' do
    before(:example) do
      FactoryBot.create(:user)
      @event1 = FactoryBot.create(:event)
      @event2 = FactoryBot.create(:event, name: 'event2', date: Date.new(2021, 2, 3))
    end

    it 'returns only event1 to be a past event' do
      expect(Event.past).to_not include(@event2)
      expect(Event.past).to include(@event1)
    end

    it 'returns only event2 to be a future event' do
      expect(Event.future).to include(@event2)
      expect(Event.future).to_not include(@event1)
    end
  end
end
