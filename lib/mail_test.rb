require 'net/smtp'

def send_mail
  mailer = Net::SMTP.new 'smtp.gmail.com', 587
  mailer.enable_starttls
  mailer.start('gmail.com', 'wookiesearch', 'mvclover', :login)
  mailer.send_message('test\n\nI sure hope this works', 'wookiesearch@gmail.com', 'wookiesearch@gmail.com')
  mailer.finish
end

send_mail