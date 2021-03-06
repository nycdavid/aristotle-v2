require 'rails_helper'

feature 'User can login' do
  before :each do
    @user = FactoryGirl.create :user
  end

  scenario 'User navigates to login page and enters valid credentials' do
    visit login_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'astrongpassword'
    click_button 'Login'

    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).to have_selector '*[rel="pursuits"]'
  end

  scenario 'User logs in and then navigates to root' do
    page.set_rack_session(user_id: @user.id)
    visit root_path
    
    expect(page).to have_link 'Pursuits'
    expect(page).not_to have_link 'Sign Up'
    expect(page).not_to have_link 'Login'
  end

  scenario 'User enters invalid email' do
    visit login_path
    fill_in 'user[email]', with: 'foo@bar.com'
    fill_in 'user[password]', with: 'something'
    click_button 'Login'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end

  scenario 'User enters invalid password' do
    visit login_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'wrongpass'
    click_button 'Login'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end

end
