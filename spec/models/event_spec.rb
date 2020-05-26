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
    before do
      User.create!(
        name: 'User1',
        email: 'apple@gmail.com'
      )
    end

    let!(:event1) do
      Event.create!(
        name: 'event1',
        description: 'desc1',
        date: Date.new(2001, 2, 3),
        creator: User.first
      )
    end

    let!(:event2) do
      Event.create!(
        name: 'event2',
        description: 'desc2',
        date: Date.new(2021, 2, 3),
        creator: User.first
      )
    end

    # 2. Actually query the database.
    it 'returns only event1 to be a past event' do
      expect(Event.past).to_not include(event2)
      expect(Event.past).to include(event1)
    end

    it 'returns only event2 to be a future event' do
      expect(Event.future).to include(event2)
      expect(Event.future).to_not include(event1)
    end
  end
end
