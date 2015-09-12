require 'rails_helper'

RSpec.describe Invitation, "#initialize" do
  let(:invitation) { FactoryGirl.create :invitation }

  it "should enforce uniqueness on code" do
    duplicate_invitation = FactoryGirl.build :invitation, code: invitation.code

    expect(duplicate_invitation).not_to be_valid
    expect(duplicate_invitation.errors.messages[:code]).to include "has already been taken"
  end
end

RSpec.describe Invitation, "#invalidate" do
  let(:user) { FactoryGirl.create :user }
  let(:invitation) { FactoryGirl.create :invitation}

  it "should invalidate the invitation and record a user" do
    invitation.invalidate(user)

    expect(invitation.used?).to eq true
    expect(invitation.user).to eq user
  end
end
