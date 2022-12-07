# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['AWS_SES_USER'],
  :password => ENV['AWS_SES_PASSWORD'],
  :domain => 'flyoner.me',
  :address => 'email-smtp.us-east-1.amazonaws.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}