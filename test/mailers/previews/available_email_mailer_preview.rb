# Preview all emails at http://localhost:3000/rails/mailers/available_email_mailer
class AvailableEmailMailerPreview < ActionMailer::Preview
	def available_email(user)
		user = User.last
		AvailableEmail.available_email(user)
	end
end
