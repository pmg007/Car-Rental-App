# Preview all emails at http://localhost:3000/rails/mailers/q_mail_mailer
class QMailMailerPreview < ActionMailer::Preview
	def signup_email
		user = User.last
		QMailMailer.signup_email(user)
	end
		
end
