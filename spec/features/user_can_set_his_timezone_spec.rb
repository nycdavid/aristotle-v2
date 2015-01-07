require 'rails_helper'

feature 'User can set his timezone' do
  let (:user) { FactoryGirl.create(:user) }
  before :each do
    page.set_rack_session(user_id: user.id)
  end

  scenario 'User navigates to account settings' do
    visit edit_user_path  
    select('Eastern Time (US & Canada)', from: 'user[timezone]')
    click_button 'Save'
    expect(page).to have_content 'Region/Time Zone: Eastern Time (US & Canada)'
  end

  scenario 'User clicks on settings link in side nav' do
    visit user_path
    click_link 'Edit Account'
    select('Eastern Time (US & Canada)', from: 'user[timezone]')
    click_button 'Save'
    expect(page).to have_content 'Region/Time Zone: Eastern Time (US & Canada)'
  end
end
