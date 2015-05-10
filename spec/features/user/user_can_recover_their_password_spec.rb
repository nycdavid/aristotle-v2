require "rails_helper"

feature "User can recover their password" do
  let(:user) { FactoryGirl.create :user }
  let(:preconfigured_token) { SecureRandom.urlsafe_base64 }

  scenario "User clicks reset password link" do
    allow(User).to receive(:new_token).and_return(preconfigured_token)
    visit login_path
    click_link "Forgot Password?"
    fill_in "password_reset[email]", with: user.email
    click_button "Submit"
    visit edit_password_reset_url(preconfigured_token, email: user.email)
    fill_in "user[password]", with: "foobar"
    fill_in "user[password_confirmation]", with: "foobar"
    click_button "Submit"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "foobar"
    click_button "Login"

    expect(page).to have_selector "*[rel='success-flash']"
  end

  scenario "User enters a non-existent email" do
    visit new_password_reset_path
    fill_in "password_reset[email]", with: "john@nonsite.com"
    click_button "Submit"

    expect(page).to have_selector "*[rel='danger-flash']"
  end

  scenario "User has an incorrect digest" do
    allow(User).to receive(:new_token).and_return(preconfigured_token)
    user.create_reset_digest
    visit edit_password_reset_url("somefaketoken", email: user.email)

    expect(page).to have_selector "*[rel='danger-flash']"
  end
end
