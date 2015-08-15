require 'rails_helper'

feature 'Guest can sign up' do
  before :each do
    visit sign_up_path
  end
  
  scenario 'Guest navigates to sign up page' do
    expect(page).not_to have_link 'My Pursuits'
  end

  scenario 'Guest goes to sign up page and enters valid information' do
    fill_in 'user[email]', with: 'person@example.com'
    fill_in "user[first_name]", with: "John"
    fill_in "user[last_name]", with: "Doe"
    fill_in 'user[password]', with: 'astrongpassword'
    fill_in 'user[password_confirmation]', with: 'astrongpassword'
    select('Eastern Time (US & Canada)', from: 'user[timezone]')
    click_button 'Sign Up'

    expect(page).to have_selector '*[rel="success-flash"]'
  end

  scenario 'Guest enters invalid information' do
    fill_in 'user[email]', with: 'person@example.com'
    fill_in 'user[password]', with: 'something'
    fill_in 'user[password_confirmation]', with: 'somethingelse'
    select('Eastern Time (US & Canada)', from: 'user[timezone]')
    click_button 'Sign Up'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end
end
