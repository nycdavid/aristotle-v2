require 'rails_helper'

describe Pursuit, 'validations' do
  before :each do
    @pursuit = FactoryGirl.build :pursuit, { name: nil }
  end

  it 'should now allow a blank name' do
    expect(@pursuit).not_to be_valid 
    expect(@pursuit.errors.messages[:name]).to include "can't be blank"
  end

end
