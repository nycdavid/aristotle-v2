require "rails_helper"

describe UsersHelper, "#region_lookup" do
  it "should return the user friendly name of a region" do
    timezone = region_lookup "America/New_York"

    expect(timezone).to eq "Eastern Time (US & Canada)"
  end
end

describe UsersHelper, "#gravatar_image_url" do
  it "should return the gravatar url for the hashed email" do
    allow(Digest::MD5).to receive(:hexdigest).and_return "somehash"
    allow(self).to receive(:current_user).and_return instance_double("User", email: Faker::Internet.email)

    expect(gravatar_image_url).to eq "http://www.gravatar.com/avatar/somehash"
  end
end

describe UsersHelper, "#display_name" do
  context "when the user#full_name returns ' '" do
    it "should return the email" do
      email = Faker::Internet.email
      allow(self).to receive(:current_user).
        and_return instance_double("User", full_name: " ", email: email)

      expect(display_name).to eq truncate(email, length: 20)
    end
  end

  context "when user#full_name returns a name" do
    it "should display the name" do
      full_name = Faker::Name.name
      allow(self).to receive(:current_user).
        and_return instance_double("User", full_name: full_name)

      expect(display_name).to eq truncate(full_name, length: 20)
    end
  end
end

describe UsersHelper, "#active?" do
  context "when the current controller/action matches the param" do
    it "should return the proper class name" do
      allow(self).to receive(:controller_name).and_return "controllers"
      allow(self).to receive(:action_name).and_return "index"
      result = active? "controllers-index"

      expect(result).to eq "nav-link--active"
    end
  end

  context "when the current controller/action does not match" do
    it "should return nil" do
      allow(self).to receive(:controller_name).and_return "foo"
      allow(self).to receive(:action_name).and_return "bar"
      result = active? "controllers-index"

      expect(result).to eq nil
    end
  end
end
