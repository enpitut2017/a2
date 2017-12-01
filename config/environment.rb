# Load the Rails application.
require_relative 'application'

sendgrid_api_key = ENV["SENDGRID_API_KEY"]

ActionMailer::Base.smtp_settings = {
  :user_name => 'sg5td9uo@idcf.kke.com',
  :password => sendgrid_api_key,
  :domain => 'y',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!
