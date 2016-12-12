require "rails_helper"

RSpec.describe "pursuits/show", type: :view do
  let(:user) { FactoryGirl.create :user }
  let(:pursuit) { FactoryGirl.create :pursuit, user: user }

  it "shows the correct date according to a User's timezone" do
    utc = Time.local(2008, 9, 2, 1, 0, 0)
    Timecop.freeze utc
    assign :pursuit, pursuit
    assign :user, user
    assign :calendar, Calendar.new(Date.today)
    render

    expect(rendered).to match /<li class='date today'>Sep 1<\/li>/
  end
end
