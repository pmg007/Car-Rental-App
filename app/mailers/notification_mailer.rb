class NotificationMailer < ApplicationMailer

default from: "carrentalcsc517@gmail.com"

  def notification_email(user)
  	@user = user
    mail(to: @user.email, subject: 'CarRental Notification')
  end

end
