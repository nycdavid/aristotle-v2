require 'rails_helper'

feature 'User can start a pomodoro' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.create :pursuit
    page.set_rack_session user_id: @user.id
  end

  scenario 'User goes to a Pursuit page and starts a new pomodoro' do
    visit user_pursuit_path @pursuit.id
    click_link 'Start Pomodoro'
    expect(page).to have_selector '*[rel="pomodori-timer"]'
  end

  scenario 'User completes a pomodoro and the time is added to the Pursuit\'s cumulative time' do
    pending
    fail
  end
end
