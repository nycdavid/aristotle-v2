require "rails_helper"

feature "User can change her password" do
  let (:user) { FactoryGirl.create :user }

  before :each do
    page.set_rack_session(user_id: user.id)
  end

  scenario "User changes her password successfully" do
    visit user_path
    click_link "edit-account"
    click_link "Change my Password"
    fill_in "user[password]", with: "foobar"
    fill_in "user[password_confirmation]", with: "foobar"
    click_button "Change Password"
    click_link "Logout"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "foobar"
    
    expect(page).to have_selector "*[rel=success-flash]"
  end
end
