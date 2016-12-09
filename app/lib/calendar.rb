class Calendar
  def initialize(date)
    @date = date
    @month = date.all_month.to_a
  end

  def date
    @date
  end

  def dates # array
    return_value = @month
    return_value = add_left_pad return_value
    return_value = add_right_pad return_value
    return_value.in_groups_of 7
  end

  private

  def left_pad_number
    Date::DAYNAMES.index @month.first.strftime("%A")
  end

  def right_pad_number
    6 - (Date::DAYNAMES.index @month.last.strftime("%A"))
  end

  def add_left_pad(calendar_dates)
    left_pad_number.times do
      calendar_dates.unshift(@month.first - 1.days)
    end
    calendar_dates
  end

  def add_right_pad(calendar_dates)
    right_pad_number.times do
      calendar_dates << (@month.last + 1.days)
    end
    calendar_dates
  end
end
