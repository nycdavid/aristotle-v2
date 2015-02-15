require 'rails_helper'

feature 'Guest gets landing page' do
  scenario 'Guest navigates to root' do
    visit root_path
    expect(page).to have_selector '*[rel="landing"]'
    expect(page).to have_link 'Sign Up'
    expect(page).to have_link 'Login'
  end
end
