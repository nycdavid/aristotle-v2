class User < ActiveRecord::Base
  has_secure_password
  has_many :pursuits

  validates_presence_of :email, :timezone

  def todays_productivity
    {
      time: pursuits.map { |pursuit| pursuit.ranged_pomodori("today")[:time] }.sum,
      pomodori: pursuits.map { |pursuit| pursuit.ranged_pomodori("today")[:count] }.sum
    }
  end
end
