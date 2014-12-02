require 'rails_helper'

describe Pomodoro, 'validations' do
  let(:pursuit) { FactoryGirl.create :pursuit }

  it 'should be related to a pursuit' do
    pomodoro = FactoryGirl.create :pomodoro, { pursuit_id: pursuit.id }

    expect(pomodoro.pursuit.id).to eq(pursuit.id)
  end

  it 'should require a pursuit_id' do
    pomodoro = FactoryGirl.build :pomodoro, { pursuit_id: nil }

    expect(pomodoro).not_to be_valid
    expect(pomodoro.errors.messages[:pursuit_id]).to include("can't be blank")
  end

  it 'should require an elapsed_time attribute' do
    pomodoro = FactoryGirl.build :pomodoro, { elapsed_time: nil, pursuit_id: pursuit.id }

    expect(pomodoro).not_to be_valid
    expect(pomodoro.errors.messages[:elapsed_time]).to include("can't be blank")
  end
end
