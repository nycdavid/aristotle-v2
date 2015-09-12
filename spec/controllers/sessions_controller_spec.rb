require 'rails_helper'

RSpec.describe SessionsController, "authentication" do
  let(:user) { FactoryGirl.create :user }  

  it "should update the last_login attribute when logging in" do
    post :create, user: { email: user.email, password: "astrongpassword" }
    user.reload

    expect(user.last_login).not_to be_nil
  end
end
