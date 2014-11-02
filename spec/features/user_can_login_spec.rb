require 'rails_helper'

feature 'User can login' do
  before :each do
    @user = FactoryGirl.create :user
  end

  scenario 'User navigates to login page and enters valid credentials' do
    pending
    fail
  end
end
