class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activate_email(user)
    @user = user
    @url = 'localhost:3000'
    mail(to: user.email, subject: 'verify your email')
  end
end
