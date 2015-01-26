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
