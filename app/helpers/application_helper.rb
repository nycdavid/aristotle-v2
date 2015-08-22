module ApplicationHelper
  def display_timer?
    action_string = "#{controller_name}-#{action_name}"
    action_string == "pomodori-new"
  end
end
