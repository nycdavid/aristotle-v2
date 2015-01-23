class Pursuit < ActiveRecord::Base
  attr_accessor :pomodoro_length_in_minutes, :pomodoro_length_in_seconds
  belongs_to :user
  has_many :pomodori

  # Validations
  validates_presence_of :name, :user_id

  # Inclusions
  include TimeConversions

  before_save :convert_length_to_seconds!

  def self.cumulative_time(pomodori_array)
    pomodori_array.map { |pom| pom.elapsed_time }
                  .inject(0) { |result, element| result + element } 
  end

  def pomodori_count
    pomodori.count
  end

  def todays_pomodori
    pomodori.where('created_at > ?', 0.days.ago.beginning_of_day + timezone_offset)
  end

  private
  def timezone_offset
    TZInfo::Timezone.get(user.timezone).current_period.utc_offset
  end

end
