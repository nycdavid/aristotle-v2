require "rails_helper"

RSpec.describe AdminsController, "authorizations" do
  let(:admin) { FactoryGirl.create :admin }
  let(:non_admin) { FactoryGirl.create :user }

  context "when a User is an Admin" do
    describe "show" do
      it "should allow access to the admin route" do
        session[:user_id] = admin.id
        get :show

        expect(response.status).to eq 200
      end
    end
  end

  context "when a User is not an Admin" do
    describe "show" do
      it "should not allow access to the admin route" do
        session[:user_id] = non_admin.id 
        get :show

        expect(response.status).to eq 302
      end
    end
  end
end
