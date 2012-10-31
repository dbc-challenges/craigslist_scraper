require 'spec_helper.rb'

describe Query do
  let(:my_query) { Query.new("1999 Miata cars", "1000", "2000", "1", "Jim") }

  context '#initialize' do
    it "returns the query" do
      my_query.content.should eq("1999+Miata+cars")
    end

    it "has a min" do
      my_query.min.should eq("1000")
    end

    it "has a max" do
      my_query.max.should eq("2000")
    end

    it "has a username" do
      my_query.username.should eq("Jim")
    end
    it "has a picture" do
      my_query.pic.should eq("1")
    end

    it "has a URL pieces" do
      my_query.url_pieces.should eq(["http://sfbay.craigslist.org/search/sss?query=1999+Miata+cars&srchType=A&", "minAsk=1000&", "maxAsk=2000", "&hasPic=1"])
    end
  end

  context '#url' do
    it "creates a url without a min" do
      new_query = Query.new("1999 Miata cars", "nil", "2000", "1", "Jim")
      new_query.url.should eq("http://sfbay.craigslist.org/search/sss?query=1999+Miata+cars&srchType=A&minAsk=&maxAsk=2000&hasPic=1")
    end

    it "creates a url without a max" do
      new_query = Query.new("1999 Miata cars", "1000", "nil", "1", "Jim")
      new_query.url.should eq("http://sfbay.craigslist.org/search/sss?query=1999+Miata+cars&srchType=A&minAsk=1000&maxAsk=&hasPic=1")
    end

    it "creates a url without a pic" do
      new_query = Query.new("1999 Miata cars", "1000", "2000", "nil", "Jim")
      new_query.url.should eq("http://sfbay.craigslist.org/search/sss?query=1999+Miata+cars&srchType=A&minAsk=1000&maxAsk=2000")
    end

    it "creates a url" do
      my_query.url.should eq("http://sfbay.craigslist.org/search/sss?query=1999+Miata+cars&srchType=A&minAsk=1000&maxAsk=2000&hasPic=1")
    end
  end

  context '#to_hash' do
    it "returns a hash containing queries data" do
      my_query.to_hash.should be_a(Hash)
      my_query.to_hash["queries"]["username"].should eq("Jim")
    end
  end

  context '#to_s' do
    it "returns the query as a properly formatted URL" do    
      my_query.to_s.should eq(my_query.url.to_s) 
      puts my_query.to_s
    end
  end
end
