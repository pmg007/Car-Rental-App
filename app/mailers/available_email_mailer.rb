class AvailableEmailMailer < ApplicationMailer
	default from: "carrentalcsc517@gmail.com"
	def available_email(user)
  		@user = user
  		mail(to:@user.email, subject: 'Your car is available now')
  	end
end
