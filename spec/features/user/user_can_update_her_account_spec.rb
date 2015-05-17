require "rails_helper"

feature "User can update their account" do
  let (:user) { FactoryGirl.create :user }

  before :each do
    page.set_rack_session(user_id: user.id)
  end

  scenario "User enters valid information" do
    visit edit_user_path
    new_email = Faker::Internet.email
    fill_in "user[email]", with: new_email
    click_button "Save"
    expect(page).to have_selector "*[rel='success-flash']"
    visit user_path
    expect(page).to have_selector "*[data-email='#{new_email}']"
  end

  scenario "User enters invalid information" do
    visit edit_user_path
    fill_in "user[email]", with: ""
    click_button "Save"
    expect(page).to have_selector "*[rel='danger-flash']"
  end
end
