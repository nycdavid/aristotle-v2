FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'astrongpassword'
    password_confirmation 'astrongpassword'
    timezone 'America/New_York'
  end
end
