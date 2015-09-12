require "rails_helper"

feature "Admin can manage all users" do
  let(:admin) { FactoryGirl.create :admin }
  let(:non_admin) { FactoryGirl.create :user }

  before :each do
    2.times { FactoryGirl.create :user }
    page.set_rack_session user_id: admin.id
  end

  it "should allow an Admin to view all Users" do
    visit user_path
    click_link "Admins"
    click_link "Users"

    expect(page).to have_selector "*[rel='users-index']"
  end

  it "should not allow non-Admins to access the admins section" do
    page.set_rack_session user_id: non_admin.id
    visit admin_path

    expect(page).to have_selector "*[rel='account-view']"
  end
end
