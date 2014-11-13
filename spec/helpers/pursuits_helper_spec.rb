require 'rails_helper'

describe PursuitsHelper, '#convert_total_seconds_of' do
  it 'should convert to the %m:%s format' do
    time = convert_total_seconds_of(900)
    expect(time).to eq('15:00')
  end
end
