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

  it "should not allow 0 minutes and seconds" do
    @pursuit.pomodoro_length_in_minutes = 0
    @pursuit.pomodoro_length_in_seconds = 0

    expect(@pursuit).not_to be_valid
    expect(@pursuit.errors.messages[:default_pomodoro_length]).to include "must be greater than 0"
  end
end

describe Pursuit, '#default_pomodoro_length' do
  before :each do
    @pursuit = FactoryGirl.create :pursuit, { pomodoro_length_in_minutes: 15, pomodoro_length_in_seconds: 0 }
  end

  it 'should convert length from %m:%s to seconds on storage' do
    expect(@pursuit.default_pomodoro_length).to eq(900)
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
  end

  
end

describe Pursuit, 'dependent destroy' do
  let(:pomodoro) { FactoryGirl.create(:pomodoro, :with_pursuit) }

  context 'when deleting a pursuit' do
    it 'should delete all related pomodori' do
      pursuit = pomodoro.pursuit
      pursuit.destroy
      expect(pursuit.pomodori).to be_empty
    end
  end
end

describe Pursuit, "#ranged_pomodori" do
  let(:user) { FactoryGirl.create :user }
  let(:users_timezone) { TZInfo::Timezone.get(user.timezone) }
  let(:pursuit) { FactoryGirl.create :pursuit, user_id: user.id }

  context "when passed today as a param" do
    it "should return only the amount of seconds completed today" do
      Timecop.
        travel(users_timezone.local_to_utc(Chronic.parse("today 1:00 AM"))) { FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id) }
      Timecop.
        travel(users_timezone.local_to_utc(Chronic.parse("today 11:00 PM"))) { FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id) }
      time = pursuit.ranged_pomodori("today")[:time]

      expect(time).to eq(20)
    end
  end

  context "when passed overall as a param" do
    before :each do
      Timecop.travel(3.days.ago) { FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id) }
      Timecop.travel(4.days.ago) { FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id) }
    end

    it "should return the amount of seconds put toward the Pursuit overall" do
      pomodori = pursuit.ranged_pomodori "overall"

      expect(pomodori[:time]).to eq(20)
      expect(pomodori[:count]).to eq(2)
    end
  end

  context "when passed a range of two dates" do
    it "should calculate properly for edge cases" do
      Timecop.travel(users_timezone.local_to_utc(Chronic.parse("05/01/15 1:00 AM"))) do
        FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id)
      end
      Timecop.travel(users_timezone.local_to_utc(Chronic.parse("05/01/15 11:00 PM"))) do
        FactoryGirl.create(:pomodoro, pursuit_id: pursuit.id)
      end
      time = pursuit.ranged_pomodori("20150501", "20150501")[:time]

      expect(time).to eq(20)
    end
  end
end
