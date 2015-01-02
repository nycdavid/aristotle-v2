require 'rails_helper'

feature 'User can view pursuit' do
  before :each do
    user = FactoryGirl.create(:user)
    @pursuit = FactoryGirl.create(:pursuit, { user_id: user.id })
    page.set_rack_session(user_id: user.id)
  end

  scenario 'User navigates to pursuit' do
    visit user_pursuit_path(@pursuit.id)   
    expect(page).to have_content @pursuit.name
  end

  scenario 'User clicks on pursuit from PursuitsIndex' do
    visit user_pursuits_path
    click_link @pursuit.name
    expect(page).to have_content @pursuit.name
  end
end
