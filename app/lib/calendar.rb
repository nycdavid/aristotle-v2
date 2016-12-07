class Calendar
  def initialize(date)
    @date = date
  end

  def preceding_month
    @date.last_month
  end

  def next_month
    @date.next_month
  end

  def dates # array
    # figure out what day the first of the month is on
    # pad the left side of day 1 with the last days of the preceding month
    # create 7 day weeks until the week that contains the last day of the current month
    # pad the right side of the last day of the month until we get to Saturday
  end

  def haml
    # Haml::Engine.new "%h1 Etcetera"
  end
end
