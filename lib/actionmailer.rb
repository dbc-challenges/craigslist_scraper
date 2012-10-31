require "action_mailer"
 
class Notifier < ActionMailer::Base
  def email(address)
    recipients  "recipient@mail.com"
    from        "you@yourdomain.com"
    subject     "Hello World"
    body        address
  end
end
 
# TLS settings are for gmail, not needed for other mail hosts.
Notifier.delivery_method = :smtp
Notifier.smtp_settings = {
  :tls => true,
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "yourdomain.com",
  :user_name => "you@yourdomain.com",
  :password => "12345",
  :authentication => :plain
}
 
Notifier.deliver_email("recipient@mail.com")