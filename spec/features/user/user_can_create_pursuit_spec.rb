require 'rails_helper'

feature 'User can create a Pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.build :pursuit
    page.set_rack_session user_id: @user.id
  end

  scenario 'User enters valid information' do
    visit new_user_pursuit_path
    fill_in 'pursuit[name]', with: @pursuit.name
    select "30", from: "pursuit_pomodoro_length_in_minutes"
    select "00", from: "pursuit_pomodoro_length_in_seconds"
    click_button 'Create'
    
    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).to have_selector "*[rel='pursuit-show']"
    expect(page).to have_content @pursuit.name
  end

  scenario 'User enters invalid information' do
    visit new_user_pursuit_path
    click_button 'Create'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end
end
