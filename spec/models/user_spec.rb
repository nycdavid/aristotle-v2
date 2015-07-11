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

describe User, "#password_reset_expired?" do
  let (:user) { FactoryGirl.build :user }

  it "should return true if password reset was initiated over two hours ago" do
    user.reset_sent_at = 3.hours.ago
    user.save

    expect(user.password_reset_expired?).to eq true
  end

  it "should return false if password reset was initiated less than two hours ago" do
    user.reset_sent_at = 1.hour.ago
    user.save

    expect(user.password_reset_expired?).to eq false
  end
end

describe User, "valid_reset_token?" do
  let (:user) { FactoryGirl.create :user, reset_digest: Digest::SHA2.hexdigest("foobar") }

  it "should return true if password reset was initiated over two hours ago" do
    expect(user.valid_reset_token?("foobar")).to eq true
  end

  it "should return false if password reset was initiated less than two hours ago" do
    expect(user.valid_reset_token?("barfoo")).to eq false 
  end
end

describe User, "#full_name" do
  let (:user) { FactoryGirl.create :user, first_name: "John", last_name: "Doe" }
  
  it "should return the user's full name" do
    expect(user.full_name).to eq "John Doe"
  end
end
