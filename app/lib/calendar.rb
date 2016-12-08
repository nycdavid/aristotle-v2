class Calendar
  def initialize(date)
    @date = date
    @month = date.all_month
  end

  def dates # array
    return_value = @month.map { |d| d.strftime "%-d" }
    return_value = add_left_pad return_value
    return_value = add_right_pad return_value
    return_value.in_groups_of 7
  end

  def haml
    # Haml::Engine.new "%h1 Etcetera"
  end

  private

  def left_pad_number
    Date::DAYNAMES.index @month.first.strftime("%A")
  end

  def right_pad_number
    6 - (Date::DAYNAMES.index @month.last.strftime("%A"))
  end

  def add_left_pad(calendar_dates)
    left_pad_number.times do |n|
      x = n + 1
      calendar_dates.unshift (@month.first - x.days).strftime "%-d"
    end
    calendar_dates
  end

  def add_right_pad(calendar_dates)
    right_pad_number.times do |n|
      x = n + 1
      calendar_dates << (@month.last + x.days).strftime("%-d")
    end
    calendar_dates
  end
end
