require 'rails_helper'

describe User, 'validations' do
  it 'should require an email' do
    @user = FactoryGirl.build(:user, { email: '' })
    expect(@user).not_to be_valid
    expect(@user.errors.messages[:email]).to include('can\'t be blank')
  end

  it 'should require a timezone' do
    @user = FactoryGirl.build(:user, { timezone: '' })
    expect(@user).not_to be_valid
    expect(@user.errors.messages[:timezone]).to include('can\'t be blank')
  end
end

describe User, "#todays_productivity" do
  let (:user) { FactoryGirl.create :user }
  let (:pursuit) { FactoryGirl.create :pursuit, user_id: user.id }

  it "should return todays productivity time" do
    FactoryGirl.create_list :pomodoro, 3, pursuit_id: pursuit.id

    expect(user.todays_productivity).to eq({ time: 30, pomodori: 3 })
  end
end
