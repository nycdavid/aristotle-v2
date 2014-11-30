require 'rails_helper'

feature 'Guest can login from landing page' do
  scenario 'Guest navigates to root' do
    visit root_path
    click_link 'Login'

    expect(page).to have_selector '*[rel="login"]'
  end
end
