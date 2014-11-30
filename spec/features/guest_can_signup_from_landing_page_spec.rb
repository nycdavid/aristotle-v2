require 'rails_helper'

feature 'Guest can signup from landing page' do
  scenario 'Guest navigates to root' do
    visit root_path 
    click_link 'Sign Up'

    expect(page).to have_selector '*[rel="signup"]'
  end
end
