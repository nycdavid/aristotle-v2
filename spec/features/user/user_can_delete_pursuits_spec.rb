require 'rails_helper'

feature 'User can delete pursuits' do
  let(:user) { FactoryGirl.create(:user) }
  let(:pursuit) { FactoryGirl.create(:pursuit, user_id: user.id) }

  before :each do
    page.set_rack_session(user_id: user.id)
    visit edit_user_pursuit_path(pursuit.id) 
  end

  scenario 'User navigates to Pursuit edit page and successfully deletes' do
    click_link 'Delete Pursuit'
    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).not_to have_content pursuit.name
  end
end
