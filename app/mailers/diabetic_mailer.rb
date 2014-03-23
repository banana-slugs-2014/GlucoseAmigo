class DiabeticMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(diabetic)
    @diabetic = diabetic
    @url  = 'http://example.com/login'
    mail(to: @diabetic.email, 
    		 subject: 'Welcome to GlucoseAmigo',
    	   template_path: 'diabetic_mailer',
         template_name: 'welcome')
  end

end

# def welcome_email(user)
#   @user = user
#   email_with_name = "#{@user.name} <#{@user.email}>"
#   mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
# end