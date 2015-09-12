require "rails_helper"

describe Admin::UsersController, "authorizations" do
  let(:admin) { FactoryGirl.create :admin }
  let(:non_admin) { FactoryGirl.create :user }

  context "when User is an Admin" do
    it "should render the Users index" do
      session[:user_id] = admin.id
      get :index

      expect(response).to render_template :index
    end
  end

  context "when User is not an Admin" do
    it "should redirect the User to the user_path" do
      session[:user_id] = non_admin.id
      get :index

      expect(response.status).to eq 302
    end
  end
end
