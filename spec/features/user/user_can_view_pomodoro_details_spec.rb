require 'rails_helper'

feature 'User can view pomodoro details' do
  before :each do
    @user = FactoryGirl.create(:user)
    @pursuit = FactoryGirl.create(:pursuit, { user_id: @user.id })
    @pomodoro = FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id, elapsed_time: 50, end_time: 50.seconds.from_now })
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User navigates to pomodoro detail' do
    visit user_pursuit_pomodoro_path(@pursuit.id, @pomodoro.id)

    expect(page).to have_content @pursuit.name
    expect(page).to have_content '00:00:50'
    expect(page).to have_content @pomodoro.start_time.strftime('%m-%d-%Y, %l:%M') 
    expect(page).to have_content @pomodoro.end_time.strftime('%m-%d-%Y, %l:%M') 
  end
end
