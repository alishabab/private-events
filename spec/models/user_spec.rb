require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_length_of(:email).is_at_least(3) }
  end
  describe 'associations' do
    it { should have_many(:created_events).class_name('Event').with_foreign_key(:creator_id) }
    it { should have_many(:attended_events).through(:invitations) }
    it { should have_many(:invitations).with_foreign_key(:attendee_id)}
  end

  describe '::users' do
    before(:example) do
    FactoryBot.create(:user)
      @event1 = FactoryBot.create(:event)
      @event2 = FactoryBot.create(:event, name: 'event2', date: Date.new(2021, 2, 3))
    end
    it 'returns only event1 to be a past event' do
      expect(User.first.created_events.past).to_not include(@event2)
      expect(User.first.created_events.past).to include(@event1)
    end

    it 'returns only event2 to be a future event' do
      expect(User.first.created_events.future).to include(@event2)
      expect(User.first.created_events.future).to_not include(@event1)
    end
  end
end
