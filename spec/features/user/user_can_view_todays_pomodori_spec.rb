require 'rails_helper'

feature 'User can view today\'s pomodori for a pursuit' do
  before :each do
    user = FactoryGirl.create(:user, { timezone: 'America/New_York' })
    page.set_rack_session(user_id: user.id)
    @pursuit = FactoryGirl.create(:pursuit, { user_id: user.id })
  end

  scenario 'User navigates to a pursuit page' do
    3.times do
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id })
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id, created_at: 1.day.ago })
    end
    visit user_pursuit_path(@pursuit.id)
    expect(page).to have_content('Pomodori Count: 3')
    expect(page).to have_content('00:00:30')
  end
end
