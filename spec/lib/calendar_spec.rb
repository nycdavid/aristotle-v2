require "rails_helper"

describe Calendar do
  let (:current_time) { DateTime.new 2015, 10, 20 }
  let (:correct_calendar_array) do
    [
      [27, 28, 29, 30, 1, 2, 3],
      [4, 5, 6, 7, 8, 9, 10],
      [11, 12, 13, 14, 15, 16, 17],
      [18, 19, 20, 21, 22, 23, 24],
      [25, 26, 27, 28, 29, 30, 31]
    ].map { |ar| ar.map { |i| i.to_s } }
  end

  it "creates an array of arrays to represent dates" do
    calendar = Calendar.new current_time

    expect(calendar.dates).to eq correct_calendar_array
  end
end
