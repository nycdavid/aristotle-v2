module TimeConversions
  extend ActiveSupport::Concern

  def convert_length_to_seconds!
    self.default_pomodoro_length = in_seconds
  end
  
  private

  def in_seconds
    (Chronic.parse("#{pomodoro_length_in_minutes.to_i} minutes and #{pomodoro_length_in_seconds.to_i} seconds from now") - Time.now).round
  end

end
