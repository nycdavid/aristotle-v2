require 'rails_helper'

feature 'User can view all Pursuits' do
  before :each do
    @user = FactoryGirl.create :user
    5.times do
      FactoryGirl.create :pursuit, { user_id: @user.id }
    end
    page.set_rack_session user_id: @user.id
  end

  scenario 'User navigates to Pursuit index' do
    pursuit = Pursuit.first
    visit user_pursuits_path
    expect(page.all('.pursuit').count).to eq(5)
  end

  scenario 'User navigates to Pursuit index from dashboard' do
    visit user_path
    click_link 'Pursuits'
    expect(page.all('.pursuit').count).to eq(5)
  end

  scenario 'User views cumulative time for a pursuit' do
    pursuit = FactoryGirl.create(:pursuit, { user_id: @user.id })
    FactoryGirl.create(:pomodoro, { pursuit_id: pursuit.id, elapsed_time: 175 })
    visit user_pursuits_path
    expect(page.find("tr[data-pursuit-id=\"#{pursuit.id}\"]").find('.time-and-count').text).to eq('00:02:55')
  end
end
