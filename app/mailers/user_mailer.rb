class UserMailer < ActionMailer::Base
  default from: "info@aristotle.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Aristotle Password Reset"
  end
end
