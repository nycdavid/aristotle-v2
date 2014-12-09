FactoryGirl.define do
  factory :pursuit do
    name { Faker::Hacker.ingverb }
    user_id { Faker::Number.digit }
  end
end
