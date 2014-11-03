require 'rails_helper'

feature 'User can create a Pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.build :pursuit
    page.set_rack_session user_id: @user.id
    visit new_user_pursuit_path
  end

  scenario 'User enter valid information' do
    fill_in 'pursuit[name]', with: @pursuit.name
    click_button 'Create'
    
    expect(page).to have_selector '*[rel="success-flash"]'
  end

  scenario 'User enters invalid information' do
    click_button 'Create'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end
end
