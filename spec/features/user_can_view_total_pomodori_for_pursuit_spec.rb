require 'rails_helper'

feature 'User can view total pomodori for Pursuit' do
  before :each do
    @user = FactoryGirl.create(:user)
    @pursuit = FactoryGirl.create(:pursuit, { user_id: @user.id })
    page.set_rack_session(user_id: @user.id)
    3.times do
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id, elapsed_time: 20 })
    end
  end

  scenario 'User navigates to Pursuit index' do
    visit user_pursuits_path
    expect(page.find("tr.pursuit[data-pursuit-id=\"#{@pursuit.id}\"]").find('td.pomodoro-count').text).to eq('3')
  end

  scenario 'User navigates to Pursuit show' do
    visit user_pursuit_path(@pursuit.id)
    expect(page.find('.pomodori-count').text).to eq('Pomodori Count: 3')
  end
end
