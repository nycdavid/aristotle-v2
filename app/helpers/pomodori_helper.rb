module PomodoriHelper
  def format_date(date)
    date.strftime('%m-%d-%Y, %l:%M')
  end
end
