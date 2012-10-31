require_relative 'spec_heper'

describe CLDatabase do

  let(:cl_db){ CLDatabase.new('test_db.db') }

  after(:all) do
    FileUtils.rm('test_db.db')
  end

  context "#insert query" do
    it "correctly executes an insert statement for queries" do
      cl_db.insert_query({"queries" => {"url" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=20000&hasPic=1", "max" => 200000, "min" => 50, "content" => "red bicycle", "created_at" => Time.now.to_s, "username" => "blah"}})
      cl_db.database.execute("select query from queries where id = ?", 1).should eq ([["http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=20000&hasPic=1"]])
    end
  end

  context "#insert post" do
    it "correctly executes an insert statement for posts" do
      cl_db.insert_post({"posts" => {"posting_ID" => 3375916191, "title" => "RED BICYCLE", "price" => "100", "location" => "San Francisco, CA", "category" => "bikes", "date_posted" => "2012-10-30 16:06:48 -0700", "unique_URL" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"}})
      cl_db.database.execute("select title from posts where posting_ID = ?", 3375916191).should eq ([["RED BICYCLE"]])
    end
  end

  context "#insert duplicate post" do
    it "correctly returns an error when inserting a duplicate post" do
      cl_db.insert_post({"posting_ID" => 3375916191, "title" => "RED BICYCLE", "price" => "100", "location" => "San Francisco, CA", "category" => "bikes", "date_posted" => "2012-10-30 16:06:48 -0700", "unique_URL" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"})
    end
  end
  context "#insert user" do
    my_first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email_address = Faker::Internet.email

    it "correctly executes an insert statement for users" do
      cl_db.insert_user({"users" => {"first_name" => my_first_name, "last_name" => last_name, "email_address" => email_address, "account_creation_date" => Time.now.to_s }})
      cl_db.database.execute("select first_name from users where id = ?", 1).should eq ([[my_first_name]])
      cl_db.insert_query({"queries" => {"url" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1", "created_at" => Time.now.to_s, "username" => "blah"}})
      cl_db.database.execute("select query from queries where id = ?", 1).should eq ([["http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"]])
    end
  end

  context "#insert post" do
    it "correctly executes an insert statement for posts" do
      cl_db.insert_post({"posts" => {"posting_ID" => 3375916191, "title" => "RED BICYCLE", "price" => "100", "location" => "San Francisco, CA", "category" => "bikes", "date_posted" => "2012-10-30 16:06:48 -0700", "unique_URL" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"}})
      cl_db.database.execute("select title from posts where posting_ID = ?", 3375916191).should eq ([["RED BICYCLE"]])
    end
  end

  context "#insert duplicate post" do
    it "correctly returns an error when inserting a duplicate post" do
      cl_db.insert_post({"posts" => {"posting_ID" => 3375916191, "title" => "RED BICYCLE", "price" => "100", "location" => "San Francisco, CA", "category" => "bikes", "date_posted" => "2012-10-30 16:06:48 -0700", "unique_URL" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"}})
    end
  end
  context "#insert user" do
    my_first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email_address = Faker::Internet.email

    it "correctly executes an insert statement for users" do
      cl_db.insert_user({"users" => {"first_name" => my_first_name, "last_name" => last_name, "email_address" => email_address, "account_creation_date" => Time.now.to_s }})
      cl_db.database.execute("select first_name from users where id = ?", 1).should eq ([[my_first_name]])
    end
  end

end
