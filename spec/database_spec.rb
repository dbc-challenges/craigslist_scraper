require_relative 'spec_helper'

describe CLDatabase do

  let(:cl_db){ CLDatabase.new('test_db.db') }

  after(:all) do
    FileUtils.rm('test_db.db')
  end

  context "#insert query" do
    it "correctly executes an insert statement" do
      cl_db.insert_query({"queries" => {"url" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1", "created_at" => Time.now.to_s, "updated_at" => Time.now.to_s, "username" => "blah"}})
      cl_db.database.execute("select query from queries where id = ?", 1).should eq ([["http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"]])
    end
  end

end