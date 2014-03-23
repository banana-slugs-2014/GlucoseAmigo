ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => "587",
      :domain => "gmail.com",
      :authentication => "plain",
      :user_name => "asdf@gmail.com",
      :password => "asdf",
      :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

if Rails.env != 'test'
  email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
  ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
end