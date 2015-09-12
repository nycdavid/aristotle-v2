FactoryGirl.define do
  factory :invitation do
    code { Faker::Code.ean }
  end
end
