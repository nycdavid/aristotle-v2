module PursuitsHelper
  def convert_total_seconds_of(time)
    "#{get_minutes(time)}:#{get_seconds(time)}"
  end

  private
    def get_minutes(time)
      (time - (time % 60)) / 60
    end

    def get_seconds(time)
      time % 60 < 10 ? "0#{time % 60}" : time % 60
    end
end
