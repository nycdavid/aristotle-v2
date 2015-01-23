require 'rails_helper'

feature 'User can start a pomodoro' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.create :pursuit, { default_pomodoro_length: 10, user_id: @user.id }
    page.set_rack_session user_id: @user.id
    visit user_pursuit_path @pursuit.id
  end

  scenario 'User goes to a Pursuit page and starts a new pomodoro' do
    click_link 'Start Pomodoro'
    expect(page).to have_selector '*[rel="pomodori-timer"]'
  end

  scenario 'User completes a pomodoro and the time is added to the Pursuit\'s cumulative time', js: true do
    pending
    fail
    visit new_user_pursuit_pomodoro_path(@pursuit.id)
    expect(page).to have_content('0:02')
  end
end
