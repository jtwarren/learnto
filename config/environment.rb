# Load the Rails application.
require File.expand_path('../application', __FILE__)
# Initialize the Rails application.
Learnto::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app18805264@heroku.com',
  :password       => '7aizmj9q',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}