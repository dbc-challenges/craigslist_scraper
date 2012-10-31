require 'simplecov'
require 'fakeweb'
require 'nokogiri'
require 'open-uri'
SimpleCov.start
require 'search_result.rb'
require 'query.rb'
FakeWeb.allow_net_connect = false

describe SearchResult do 


  cl_url = 'http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1'
  FakeWeb.register_uri(:get, "#{cl_url}", :response => "../search_results/response_from_cl_search.html")
  let (:search_result) { SearchResult.new("#{cl_url}") }
  let (:nokogiri_object) { search_result.parse_results(cl_url) }
  let (:my_query) { Query.new("bike", "1", "600", "1", "Jim") }
   
  context '#initialize' do

    it "returns an error when passed an invalid URI" do
      expect {SearchResult.new("htp:/badurl.com")}.to raise_error
    end

    it "does not return an error when passed a valid URI" do
      expect {SearchResult.new("http://validurl.com")}.to_not raise_error
    end

    it "initializes with no postings in its list" do
      search_result.has_postings?.should eq(false)
    end

    it "receives and uses a query for initialization" do
      expect { SearchResult.new(my_query.url) }.to_not raise_error
    end
  end

  context '#parse_results' do
    it 'parses the returned HTML into a Nokogiri object' do
      search_result.parse_results(cl_url).include? instance_of(Nokogiri)
    end
  end

  context '#parse_listed_dates' do
    it 'returns date items from query' do     
      search_result.parse_listed_dates(nokogiri_object).first.should =~ /\w{3}\s\d\d?/
    end
  end

  context '#parse_posting_title' do
    it 'returns posting title from query' do
      search_result.parse_posting_title(nokogiri_object).first.should =~ /1999 Dodge Ram 1500 Quad Cab 5.9L V8/
    end
  end

  context '#parse_posting_price' do
    it 'returns posting price from query' do
      search_result.parse_posting_price(nokogiri_object).first.should =~ /\$5995/ 
    end
  end

  context '#parse_location' do
    it 'returns posting location from query' do
      search_result.parse_location(nokogiri_object).first.should =~ /(milpitas)/ 
    end
  end

  context '#parse_category' do
    it 'returns posting category from query' do
      search_result.parse_category(nokogiri_object).first.should =~ /cars \& trucks - by dealer/ 
    end
  end

  context '#parse_unique_url' do
    it 'returns unique item URL from query' do
      search_result.parse_unique_url(nokogiri_object).first.should == "http://sfbay.craigslist.org/sby/ctd/3372616665.html"
    end
  end

  context '#parse_unique_posting_id' do
    it 'returns unique posting id from query' do
      search_result.parse_unique_posting_id(nokogiri_object).first.should =~ /\d{10}/ 
    end
  end

  context '#parse_posting' do
    it 'returns date posted, posting title, listing price, location, category, and unique url from a posting' do
      search_result.parse_posting(nokogiri_object).first.length.should eq(7)
    end
  end

  context '#create_posts_list' do
    it 'creates an array of posts using fake parsed data' do
      search_result.create_posts_list(nokogiri_object)
      search_result.postings.sample.should be_instance_of(Post)
    end

    it 'creates an array of posts using real data from a query' do
      test_search = SearchResult.new(my_query.to_s)
      nokogiri_object = test_search.parse_results(my_query.to_s)
      test_search.create_posts_list(nokogiri_object)
      test_search.postings.sample.should be_instance_of(Post)
    end
  end


 end

