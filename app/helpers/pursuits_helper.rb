module PursuitsHelper
  def convert_total_seconds_of(time)
    @time = time
    "#{calculate_hours}:#{calculate_minutes}:#{calculate_seconds}"
  end

  def minute_selections
    %w(1 5 10 15 20 25 30 45 60 90 120).map do |choice|
      [choice.to_s.rjust(2, "0"), choice]
    end
  end

  def second_selections
    0.step(60, 10).map do |choice|
      [choice.to_s.rjust(2, "0"), choice]
    end
  end

  def default_minutes
    (@pursuit.default_pomodoro_length / 60)
  end

  def default_seconds
    @pursuit.default_pomodoro_length - (@pursuit.default_pomodoro_length / 60) * 60
  end

  def context_link(context)
    if context == @range
      content_tag(:strong, context.capitalize)
    else
      link_to context.capitalize, "/user/pursuits?range=#{context}"
    end
  end

  def date_classes(day, week)
    classes = ["date"]
    if week.index(day) == 0
      classes << "first"
    end
    today = Date.today.in_time_zone(@user.timezone).to_date
    if day === today
      classes << "today"
    end
    if @pursuit.contributed_on? day
      classes << "contributed"
    end
    unless @calendar.date.all_month.include? day
      classes << "nonmonth"
    end
    classes.join " "
  end

  def calendar_date_display(day)
    if @calendar.date.beginning_of_month == day
      "#{day.strftime "%b"} 1"
    else
      "#{day.strftime "%-d"}"
    end
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
