FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'astrongpassword'
    password_confirmation 'astrongpassword'
    timezone 'America/New_York'
  end
end
