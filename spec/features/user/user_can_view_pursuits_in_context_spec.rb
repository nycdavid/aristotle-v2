require "rails_helper"

feature "User can view pursuits in context" do
  let (:user) { FactoryGirl.create :user }
  let (:pursuit) { FactoryGirl.create :pursuit, user_id: user.id }

  before :each do
    page.set_rack_session user_id: user.id
    FactoryGirl.create :pomodoro, pursuit_id: pursuit.id, created_at: Time.now
    FactoryGirl.create :pomodoro, pursuit_id: pursuit.id, created_at: 1.hour.ago
    FactoryGirl.create :pomodoro, pursuit_id: pursuit.id, created_at: 2.days.ago
  end

  scenario "User navigates to default view (no range params)" do
    visit user_pursuits_path

    expect(page).to have_content "00:00:30"
  end

  scenario "User clicks on daily view" do
    visit user_pursuits_path
    click_link "Today"

    expect(page).to have_content "2 / 00:00:20"
    expect(page.find("div[rel='pursuits-context']")).not_to have_selector "a[href='/user/pursuits?range=today']"
  end

  scenario "User clicks on overall view" do
    visit user_pursuits_path

    expect(page).to have_content "3 / 00:00:30"
    expect(page.find("div[rel='pursuits-context']")).not_to have_selector "a[href='/user/pursuits?range=overall']"
  end
end
