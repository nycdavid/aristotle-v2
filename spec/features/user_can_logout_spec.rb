require 'rails_helper'

feature 'User can logout' do
  scenario 'when he is signed in' do
    user = FactoryGirl.create :user
    page.set_rack_session(user_id: user.id)
    visit user_path
    click_link 'Logout'
    expect(page).to have_selector '*[rel="success-flash"]'
    expect(page).to have_selector '*[rel="login"]'
  end
end
