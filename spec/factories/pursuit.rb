FactoryGirl.define do
  factory :pursuit do
    name { Faker::Hacker.ingverb }
    user
    pomodoro_length_in_seconds 10
    pomodoro_length_in_minutes 0
  end
end
