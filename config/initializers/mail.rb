ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  address: ENV['STORM_SMTP_ADDRESS'],
  port: (ENV['STORM_SMTP_PORT'] || 25),
  user_name: ENV['STORM_SMTP_USERNAME'],
  password: ENV['STORM_SMTP_PASSWORD'],
  domain: ENV['STORM_SMTP_DOMAIN']  
}
