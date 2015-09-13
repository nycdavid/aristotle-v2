require 'rails_helper'

RSpec.describe InspirationalQuote, ".random" do
  it "should return an instance of InspirationalQuote" do
    inspirational_quote = InspirationalQuote.random 

    expect(inspirational_quote).to be_a Hash
  end
end
