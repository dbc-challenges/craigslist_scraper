require 'net/smtp'

class Email

  def initialize
    @email_domain = 'gmail.com'
    @mailer_account_id = 'wookiesearch'
    @password = 'mvclover'
    @sender_email = 'wookiesearch@gmail.com'
    @body_temp = ""
  end

  def body(data)
    @body_temp = ""
    data.each do |datum|
      @body_temp << "#{datum[:date]} - #{datum[:title]} -#{datum[:price]} -#{datum[:location]} -#{datum[:category]}\n #{datum[:url]}\n"
    end
    @body_temp
  end

  def subject_line(subject = 'your newest wookiesearch results!')
    "Subject: #{subject}\n\n"
  end

  def message
    subject_line(@subject) + body(@data)
  end

  def recipient_email
    'wookiesearch@gmail.com'
  end

  def send_mail(data, subject)
    @data = data
    @subject = subject
    mailer.enable_starttls
    mailer.start(@email_domain, @mailer_account_id, @password, :login)
    mailer.send_message(message, @sender_email, recipient_email)
    mailer.finish
  end

  def mailer
    @mailer ||= Net::SMTP.new 'smtp.gmail.com', 587
  end

end

mail = Email.new
mail.send_mail([{:date => " Oct 29",
          :title => "1999 Dodge Ram 1500 Quad Cab 5.9L V8",
          :price => " $5995",
          :location => " (milpitas)",
          :category => " cars & trucks - by dealer",
          :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"},
         {:date => " Oct 29",
          :title => "1999 Dodge Ram 3500 Quad Cab 5.9L V8",
          :price => " $5995",
          :location => " (milpitas)",
          :category => " cars & trucks - by dealer",
          :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"}], "timed email")