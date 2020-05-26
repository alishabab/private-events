require 'rails_helper'

feature 'the sigup process' do
  before(:example) do
    visit new_user_url
  end

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end
end

feature 'signing up a user' do
  before(:example) do
    visit new_user_path
    fill_in 'user_name', with: 'testing'
    fill_in 'user_email', with: 'test@gmail.com'
    click_on 'Create User'
  end

  scenario 'redirects to user show page after signup' do
    expect(page).to have_content 'Showing all events created by user'
  end

  scenario 'shows username on the top of page after signup' do
    expect(page).to have_content 'testing'
  end
end

feature 'signing in as a non-existant user' do
  before(:example) do
    visit '/login'
    fill_in 'email', with: 'test@gmail.com'
    click_on 'Login'
  end

  scenario 'does not re-direct to user page' do
    expect(page).not_to have_content 'Showing all events created by user'
  end

  scenario 'does not show username on the homepage after signup' do
    expect(page).not_to have_content 'testing'
  end
  scenario 'gives error of user not existing' do
    expect(page).to have_content 'User does not Exist'
  end
end

feature 'signing in as an existing user' do
  before(:example) do
    FactoryBot.create(:user)
    visit '/login'
    fill_in 'email', with: 'apple@gmail.com'
    click_on 'Login'
  end

  scenario 'redirects to user page after signup' do
    expect(page).to have_content 'Showing all events created by user'
  end

  scenario 'shows username on the homepage after signup' do
    expect(page).to have_content 'User1'
  end
  scenario 'Does not give error of user not existing' do
    expect(page).not_to have_content 'User does not Exist'
  end
end
