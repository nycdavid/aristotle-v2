module Admin::UsersHelper
  def last_login_info(user)
    return if user.last_login.nil?
    difference = Time.now - user.last_login
    number_of_days = (difference / 1.day).round
    "#{user.last_login.strftime("%m/%d/%y")} (#{number_of_days} days ago)"
  end
end
