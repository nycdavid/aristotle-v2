FactoryGirl.define do
  factory :pomodoro do
    start_time DateTime.now
    elapsed_time 10
  end

  trait :with_pursuit do
    association :pursuit
  end
end
