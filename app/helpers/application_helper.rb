module ApplicationHelper
  def timer_display
    action_string = "#{controller_name}-#{action_name}"
    if action_string == "pomodori-new"
      "{{ time }}"
    else
      "Aristotle"
    end
  end
end
