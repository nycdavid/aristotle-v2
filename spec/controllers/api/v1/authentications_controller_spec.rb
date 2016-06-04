require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController do
  describe "POST" do
    let(:user) { FactoryGirl.create :user }
    let(:jwt) do
      payload = { iss: "Aristotle API", user_type: "user", id: user.id }
      JWT.encode payload, Rails.application.secrets[:secret_key_base]
    end

    it "should return a 200 with JWT when credentials are correct" do
      post :create, { authentication: { email: user.email, password: "astrongpassword" } }
      last_response = JSON.parse(response.body)

      expect(last_response["jwt"]).to eq jwt
    end

    it "should return a 401 when credentials are incorrect" do
      post :create, { authentication: { email: user.email, password: "awrongpassword" } }

      expect(response.status).to eq 401
    end
  end
end
