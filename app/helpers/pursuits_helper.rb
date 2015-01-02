module PursuitsHelper
  def convert_total_seconds_of(time)
    @time = time
    "#{calculate_hours}:#{calculate_minutes}:#{calculate_seconds}"
  end

  private
    def hours
      @time / 60 / 60
    end

    def minutes
      @time / 60
    end
    
    def seconds
      @time % 60
    end

    def calculate_hours
      pad(hours)
    end

    def calculate_minutes
      pad(minutes - hours * 60)
    end

    def calculate_seconds
      pad(seconds)
    end

    def pad(time)
      time < 10 ? "0#{time}" : time
    end

end
