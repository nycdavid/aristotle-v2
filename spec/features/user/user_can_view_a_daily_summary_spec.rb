require "rails_helper"

feature "User can view a daily summary on the Pursuits index in the daily context" do
  let (:user) { FactoryGirl.create :user }
  let (:pursuit) { FactoryGirl.create :pursuit, user_id: user.id }
  let (:other_pursuit) { FactoryGirl.create :pursuit, user_id: user.id }

  before :each do
    page.set_rack_session user_id: user.id
  end

  scenario "User navigates to Pursuits page" do
    FactoryGirl.create_list :pomodoro, 3, pursuit_id: pursuit.id
    FactoryGirl.create_list :pomodoro, 2, pursuit_id: pursuit.id
    visit "/user/pursuits?range=today"
    
    expect(find("tfoot td[rel='pomodori-time']").text).to eq("00:00:50")
  end
end
