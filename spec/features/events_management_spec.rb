require 'rails_helper'

feature 'the event page' do
  before(:each) do
    FactoryBot.create(:user)
    visit '/login'
    fill_in 'email', with: 'apple@gmail.com'
    click_on 'Login'
  end

  scenario 'Can view events on user page' do
    expect(page).to have_content 'Showing all events created by user'
  end

  scenario 'Can view all events on Event lists' do
    click_on '--- Events List ---'
    expect(page).to have_content "All Events\nPast Events\nFuture Events"
  end

  scenario 'Can go to create new event page' do
    click_on '--- Create new event ---'
    expect(page).to have_content 'Name Description Date'
  end

  scenario 'Can create new event' do
    click_on '--- Create new event ---'
    fill_in 'event_name', with: 'testing'
    fill_in 'event_description', with: 'This is a test'
    fill_in 'event_date', with: Date.new
    click_on 'Create Event'
    expect(page).to have_content 'testing'
  end
end
