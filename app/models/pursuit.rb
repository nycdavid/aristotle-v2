class Pursuit < ActiveRecord::Base
  attr_accessor :pomodoro_length_in_minutes, :pomodoro_length_in_seconds
  belongs_to :user
  has_many :pomodori, dependent: :destroy

  # Validations
  validates_presence_of :name, :user_id
  validates :default_pomodoro_length, numericality: { greater_than: 0 }

  # Inclusions
  include TimeConversions

  before_validation :convert_length_to_seconds!

  def pomodori_count
    pomodori.count
  end

  def todays_pomodori
    all_pomodori("today")
  end

  def ranged_time(lower_bound=beginning_of_time, upper_bound=end_of_today)
    Pursuit.
      cumulative_time all_pomodori(lower_bound, upper_bound)
  end

  def all_pomodori(lower_bound=beginning_of_time, upper_bound=end_of_today)
    pomodori.
      where("created_at > ? AND created_at < ?", start_of_day(lower_bound), end_of_day(upper_bound))
  end

  private

  def start_of_day(date_string)
    if date_string == "today"
      date = users_timezone.now.beginning_of_day
    elsif date_string == "overall"
      date = Time.new(2000)
    else
      date = Time.strptime(date_string, "%Y%m%d").beginning_of_day
    end
    users_timezone.local_to_utc(date)
  end

  def end_of_day(date_string)
    date = Time.strptime(date_string, "%Y%m%d").end_of_day
    users_timezone.local_to_utc(date)
  end
  
  def users_timezone
    TZInfo::Timezone.get(user.timezone)
  end

  def end_of_today
    users_timezone.now.strftime("%Y%m%d")
  end

  def self.cumulative_time(pomodori_array)
    pomodori_array.map { |pom| pom.elapsed_time }
                  .inject(0) { |result, element| result + element } 
  end
end
