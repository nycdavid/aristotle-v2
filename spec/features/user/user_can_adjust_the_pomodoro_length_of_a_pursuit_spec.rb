require 'rails_helper'

feature 'User can edit a pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.create(:pursuit, user_id: @user.id)
    page.set_rack_session user_id: @user.id
  end

  scenario 'User edits default pomodoro length by navigating to edit page' do
    visit edit_user_pursuit_path @pursuit
    select "30", from: "pursuit_pomodoro_length_in_minutes"
    select "00", from: "pursuit_pomodoro_length_in_seconds"
    click_button 'Save'

    expect(page).to have_selector '*[rel="success-flash"]'
  end

  scenario 'User can edit a pursuit by clicking edit from index page' do
    visit user_pursuits_path
    click_link "edit-pursuit"

    expect(page).to have_content "Edit: #{@pursuit.name}"
  end
end
