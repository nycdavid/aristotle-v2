require 'rails_helper'

feature 'Guest cannot access the protected sections' do
  scenario 'when he is not signed in' do
    visit user_path
    expect(page).to have_selector '*[rel="404-not-found"]'
    expect(page).not_to have_link 'My Pursuits'
  end
end
