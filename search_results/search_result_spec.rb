require 'simplecov'
SimpleCov.start
require_relative 'search_result'


# require 'open-uri'
# doc = Nokogiri::HTML(open("http://www.threescompany.com/"))


describe SearchResult do 

  let (:search_result) {SearchResult.new("http://www.craigslist.com")}
  let (craigslist) {SearchResult.new(craigslist = FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1", :response => page)
   
  context '#initialize' do

    it "returns an error when passed an invalid URI" do
      expect {SearchResult.new("htp:/badurl.com")}.should raise_error
    end

    it "does not return an error when passed a valid URI" do
      expect {SearchResult.new("http://validurl.com")}.should_not raise_error
    end

    it "initializes with no postings in its list" do
      search_result.has_postings?.should eq(false)
    end
  end

  context '#parse_url' do
    it ''
  end
end