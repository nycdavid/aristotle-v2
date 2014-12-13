require 'rails_helper'

describe PomodoriHelper, '#format_date(date)' do
  it 'should return a date string in the format of "%m-%d-%Y, %l:%M"' do
    now = DateTime.now
    expect(format_date(now)).to eq(now.strftime('%m-%d-%Y, %l:%M'))
  end
end
