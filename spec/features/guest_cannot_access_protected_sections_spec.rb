require 'rails_helper'

feature 'Guest cannot access the protected sections' do
  scenario 'when he is not signed in' do
    visit user_path
    expect(page).to have_content '404'
  end
end
