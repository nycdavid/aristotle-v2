require 'rails_helper'

describe Pursuit, 'validations' do
  before :each do
    @pursuit = FactoryGirl.build :pursuit
  end

  it 'should be associated with multiple pomodori' do
    @pursuit.save!
    2.times do
      FactoryGirl.create :pomodoro, { pursuit_id: @pursuit.id, elapsed_time: 5 }
    end

    expect(@pursuit.pomodori.count).to eq(2)
  end

  it 'should not allow a blank name' do
    @pursuit.name = nil

    expect(@pursuit).not_to be_valid 
    expect(@pursuit.errors.messages[:name]).to include "can't be blank"
  end

  it 'should not allow a blank user_id' do
    @pursuit.user_id = nil

    expect(@pursuit).not_to be_valid
    expect(@pursuit.errors.messages[:user_id]).to include "can't be blank"
  end
end

describe Pursuit, '#default_pomodoro_length' do
  before :each do
    @pursuit = FactoryGirl.create :pursuit, { pomodoro_length_in_minutes: 15 }
  end

  it 'should convert length from %m:%s to seconds on storage' do
    expect(@pursuit.default_pomodoro_length).to eq(900)
  end
end

describe Pursuit, '::cumulative_time' do
  before :each do
    @pursuit = FactoryGirl.create :pursuit, { pomodoro_length_in_minutes: 15 }
    2.times do
      FactoryGirl.create :pomodoro, { pursuit_id: @pursuit.id }
    end
    @pomodori_array = Pomodoro.all
  end

  it 'should return the total seconds put to the pursuit' do
    expect(Pursuit.cumulative_time(@pomodori_array)).to eq(20)
  end
end

describe Pursuit, '#pomodori_count' do
  before :each do
    @pursuit = FactoryGirl.create(:pursuit)
    3.times do
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id })
    end
  end

  it 'should return the total number of pomodori that belong to self' do
    expect(@pursuit.pomodori_count).to eq(3)
  end
end

describe Pursuit, '#todays_pomodori' do
  before :each do
    user = FactoryGirl.create(:user)
    @pursuit = FactoryGirl.create(:pursuit, { user_id: user.id })
    3.times do
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id })
      FactoryGirl.create(:pomodoro, { pursuit_id: @pursuit.id, created_at: 1.day.ago })
    end
  end

  it 'should only return pomodori that were created today (America/New_York' do
    expect(@pursuit.todays_pomodori.count).to eq(3)
  end
end
