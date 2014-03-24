class DoctorMailer < ActionMailer::Base
  default from: "glucoseamigo@gmail.com"

  def welcome_email(doctor)
    @doctor = doctor
    mail(to: @doctor.email, 
    		 subject: 'Welcome to GlucoseAmigo',
    	   template_path: 'doctor_mailer',
         template_name: 'welcome')
  end

  def attachment_email(doctor, diabetic, pdf)
    @doctor = doctor
    @diabetic = diabetic
    attachments['report'] = pdf
    mail(to: @doctor.email, 
         subject: "#{diabetic.name}'s Report from GlucoseAmigo",
         template_path: 'doctor_mailer',
         template_name: 'report')
  end

end