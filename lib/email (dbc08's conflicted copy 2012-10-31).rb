require 'net/smtp'
require '../spec/spec_helper.rb'

class Email

  def initialize
    @email_domain = 'gmail.com'
    @mailer_account_id = 'wookiesearch'
    @password = 'mvclover'
    @sender_email = 'wookiesearch@gmail.com'
    @body_temp = ""
  end

  def initialize(user = 1)
    @user = user
    @db = CLDatabase.new
  end

  def retrieve_posts
    @user_data ||= @db.get_user_posts(@user)
  end

  def body(data)
    @body_temp = ""
    data[0..2].each do |datum|
      @body_temp << "#{datum[5]} - #{datum[1]} -#{datum[2]} -#{datum[3]} -#{datum[4]}\n" #\n #{datum[:url]}
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
    puts retrieve_posts['email_address']
    retrieve_posts['email_address'].flatten.to_s
  end

  def run_mailer
    imported_data = retrieve_posts["posts"]
    send_mail(imported_data, "search results")
  end

  def send_mail(data, subject)
    @data = data
    @subject = subject
    mailer = Net::SMTP.new 'smtp.gmail.com', 587
    mailer.enable_starttls
    mailer.start('gmail.com', 'wookiesearch', 'mvclover', :login)
    puts message.inspect
    puts "*******************************"
    puts recipient_email.inspect
    mailer.send_message(message, @sender_email, recipient_email)
    mailer.finish
  end

  def mailer2
    @mailer ||= Net::SMTP.new 'smtp.gmail.com', 587
  end

end

mail = Email.new
mail.run_mailer

# mail = Email.new
# mail.send_mail([[3376352490, "*** 2010 TOYOTA TUNDRA DOUBLE CAB TRUCK GOOD *** - $6210", "", " (stockton)", " <<cars & trucks - by dealer", " Oct 30", nil, 1, 3376352490], [3376439125, "*** 2010 TOYOTA TUNDRA DOUBLE CAB TRUCK GARAGE KEPT ***", " $6232", " (SF bay area)", " cars & trucks - by dealer", " Oct 30", nil, 1, 3376439125]], "timed email")