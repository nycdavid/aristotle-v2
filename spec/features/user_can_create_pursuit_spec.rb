require 'rails_helper'

feature 'User can create a Pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.build :pursuit
    page.set_rack_session user_id: @user.id
  end

  scenario 'User creates pursuit from Pursuits Index' do
    visit user_pursuits_path
    click_link 'New Pursuit'
    fill_in 'pursuit[name]', with: @pursuit.name
    click_button 'Create'
    
    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).to have_selector "*[data-pursuit-name='#{@pursuit.name}']"
  end

  scenario 'User enters valid information' do
    visit new_user_pursuit_path
    fill_in 'pursuit[name]', with: @pursuit.name
    click_button 'Create'
    
    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).to have_selector "*[data-pursuit-name='#{@pursuit.name}']"
  end

  scenario 'User enters invalid information' do
    visit new_user_pursuit_path
    click_button 'Create'

    expect(page).to have_selector '*[rel="danger-flash"]'
  end
end
