require 'rails_helper'

feature 'User can adjust the pomodoro length of a pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.create(:pursuit, { user_id: @user.id })
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User navigates to pursuit edit page and selects a radio button to adjust time' do
    visit edit_user_pursuit_path @pursuit
    fill_in 'pursuit[pomodoro_length_in_minutes]', with: '15'
    click_button 'Save'

    expect(page).to have_selector '*[rel="success-flash"]'
    expect(find("tr[data-pursuit-id='#{@pursuit.id}']").find('.default-pomodoro-length').text).to eq('15:00')
  end
end
