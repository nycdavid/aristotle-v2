class DataReport
  def initialize(pursuit)
    @pursuit = pursuit
    @timezone = TZInfo::Timezone.get(@pursuit.user.timezone)
  end

  def pomodori_on(date)
    beginning_of_day = utc_of(parse(date))
    end_of_day = utc_of(parse(date) + 24.hours)
    timebox_pomodori(beginning_of_day, end_of_day)
  end

  def total_time_on(date)
    pomodori = pomodori_on(date)
    pomodori.map { |pomodoro| pomodoro.elapsed_time }.sum
  end

  private

  def timebox_pomodori(start_date, end_date)
    @pursuit.pomodori.
      where("created_at > ? AND created_at < ?", start_date, end_date)
  end


  def utc_of(date_object)
    @timezone.local_to_utc(date_object)
  end

  def parse(date_string)
    DateTime.strptime date_string, "%m/%d/%Y"
  end
end
