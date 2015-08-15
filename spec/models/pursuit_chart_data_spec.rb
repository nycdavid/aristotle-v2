require "rails_helper"

describe PursuitChartData, "#within_range" do
  let(:pursuit) { FactoryGirl.create :pursuit }

  before :each do
    # This one translates to the day before in New York time, shouldn't be factored in
    Timecop.travel(Time.utc(2012, 9, 1, 3, 59)) { FactoryGirl.create :pomodoro, pursuit: pursuit }
     
    # These will count for 2012-9-1
    Timecop.travel(Time.utc(2012, 9, 1, 5)) do 
      2.times { FactoryGirl.create :pomodoro, pursuit: pursuit, elapsed_time: 1800 }
    end
  end

  it "should prepare the labels" do
    date_range = ["01/01/2012", "01/02/2012", "01/03/2012"]
    chart_data = PursuitChartData.new(pursuit).within_range(date_range)

    expect(chart_data[:labels]).to match_array(date_range)
  end
  
  it "should prepare the data" do
    date_range = ["09/01/2012"]
    chart_data = PursuitChartData.new(pursuit).within_range(date_range)

    expect(chart_data[:labels]).to match_array date_range
    expect(chart_data[:datasets].first[:data]).to match_array [1]
  end
end

describe PursuitChartData, "#count_backward_from_today" do
  let(:pursuit) { FactoryGirl.create :pursuit }

  before :each do
    # This one translates to the day before in New York time, shouldn't be factored in
    Timecop.travel(Time.utc(2012, 9, 1, 3, 59)) { FactoryGirl.create :pomodoro, pursuit: pursuit }
     
    # These will count for 2012-9-1
    Timecop.travel(Time.utc(2012, 9, 1, 5)) do 
      2.times { FactoryGirl.create :pomodoro, pursuit: pursuit, elapsed_time: 1800 }
    end
  end

  it "should have the proper labels" do
    date_range = [3.days, 2.days, 1.days, 0.days].map do |date|
      (pursuit.user.now - date).strftime("%m/%d/%Y")
    end
    chart_data = PursuitChartData.new(pursuit)

    expect(chart_data.count_backward_from_today(3)[:labels]).to match_array date_range
  end
end
