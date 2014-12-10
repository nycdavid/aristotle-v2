require 'rails_helper'

describe User, 'validations' do
  it 'should require an email' do
    user = FactoryGirl.build(:user, { email: '' })

    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to include('can\'t be blank')
  end
end
