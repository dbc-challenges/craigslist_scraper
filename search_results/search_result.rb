class InvalidQuery < Exception; end


 craigslist = FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1", :response => page)
 Net::HTTP.get(URI.parse("http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1"))


class SearchResult

  def initialize(url)
    @url = check_url(url)
    @postings = []
  end

  def check_url(url)
    raise InvalidQuery, "Invalid Query String" unless url =~ /^http:\/\/.+/ 
  end

  def has_postings?
    @postings.length > 0    
  end

end


#date posted
#posting title
#listing price
#location
#category
#unique url

