FactoryGirl.define do
  factory :pursuit do
    name { Faker::Hacker.ingverb }
    user_id { Faker::Number.digit }
    pomodoro_length_in_seconds 10
    pomodoro_length_in_minutes 0

    association :user, factory: :user
  end
end
