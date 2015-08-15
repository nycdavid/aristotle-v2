require "rails_helper"

describe DataReport, "#pomodori_on" do
  let(:pursuit) { FactoryGirl.create :pursuit }

  before :each do
    # This one translates to the day before in New York time, shouldn't be factored in
    Timecop.travel(Time.utc(2012, 9, 1, 3, 59)) { FactoryGirl.create :pomodoro, pursuit: pursuit }
     
    # These will count for 2012-9-1
    Timecop.travel(Time.utc(2012, 9, 1, 5)) do 
      2.times { FactoryGirl.create :pomodoro, pursuit: pursuit }
    end
  end

  it "should return the pomodori for a specific day" do
    data_report = DataReport.new(pursuit)
    pomodori = data_report.pomodori_on "09/01/2012"

    expect(pomodori.count).to eq 2
  end
end

describe DataReport, "#total_time_on" do
  let(:pursuit) { FactoryGirl.create :pursuit }

  before :each do
    # This one translates to the day before in New York time, shouldn't be factored in
    Timecop.travel(Time.utc(2012, 9, 1, 3, 59)) { FactoryGirl.create :pomodoro, pursuit: pursuit }
     
    # These will count for 2012-9-1
    Timecop.travel(Time.utc(2012, 9, 1, 5)) do 
      2.times { FactoryGirl.create :pomodoro, pursuit: pursuit }
    end
  end

  it "should return the total seconds on a particular date" do
    data_report = DataReport.new(pursuit)
    time = data_report.total_time_on("09/01/2012")

    expect(time).to eq 20
  end
end
