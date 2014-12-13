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
    visit user_pursuits_path
    expect(page.all('.pursuit').count).to eq(5)
  end

  scenario 'User navigates to Pursuit index from dashboard' do
    visit user_path
    click_link 'My Pursuits'
    expect(page.all('.pursuit').count).to eq(5)
  end
end
