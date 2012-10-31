require 'SimpleCov'
SimpleCov.start

require '../lib/email.rb'

describe Email do

  context "generating email from posts pulled from db" do

      it "should format a string based off of the posts provided to it" do
        posts = [{:date => " Oct 29",
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
                  :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"}]
        string_generator = Email.new
        string_generator.body(posts).should eq(" Oct 29 - 1999 Dodge Ram 1500 Quad Cab 5.9L V8 - $5995 - (milpitas) - cars & trucks - by dealer\n http://sfbay.craigslist.org/sby/ctd/3372616665.html\n Oct 29 - 1999 Dodge Ram 3500 Quad Cab 5.9L V8 - $5995 - (milpitas) - cars & trucks - by dealer\n http://sfbay.craigslist.org/sby/ctd/3372616665.html\n")
      end

      it "formats the subject line for the email" do
        subject_liner = Email.new
        subject_liner.subject_line.should eq("Subject: your newest wookiesearch results!\n\n")
      end

  end

  context "sending and email" do

    it "should send an email with the correct data via NET::SMTP" do
      mail_sender = Email.new
      subject = "subjected!"
      body = [{:date => " Oct 29",
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
                :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"}]
      mock_smtp = mock("NET::SMPT")
      mail_sender.stub!(:mailer).and_return(mock_smtp)

      mock_smtp.should_receive(:enable_starttls)
      mock_smtp.should_receive(:start).with('gmail.com','wookiesearch','mvclover', :login)
      mock_smtp.should_receive(:send_message)
      mock_smtp.should_receive(:finish)
      mail_sender.send_mail(body, subject)
    end



  end
end