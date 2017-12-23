class QMailMailer < ApplicationMailer
	default from: "carrentalcsc517@gmail.com"
	def timeout_email(user)
	    @user = user
	    # @url  = 'http://example.com/login'
	    mail(to: @user.email, subject: 'Your car booking has been cancelled')
  	end

  	def avail_email(user)
	    @user = user
	    # @url  = 'http://example.com/login'
	    mail(to: @user.email, subject: 'Your car has become available.')
  	end
 end
#QMailMailer.timeout_email(user).deliver_now