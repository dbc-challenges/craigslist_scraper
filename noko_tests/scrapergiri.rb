require 'open-uri'
require 'nokogiri'
require 'fakeweb'


#Fakeweb
cl_url = 'http://sfbay.craigslist.org/search/sss?query=test&srchType=A&minAsk=1&maxAsk=2000&hasPic=1'

FakeWeb.register_uri(:get, "#{cl_url}", :response => "response.html")

#Nokogirixx`

class Scrape
  #get entire page as Nokogiri object
  def parse_results(url)
    returned_page = Nokogiri::HTML(open(url))
  end

  def parse_listed_dates(nokogiri_object)
    temp_array = []
    nokogiri_object.css('p.row span.itempp').each {|i| temp_array << i.children.text}
    temp_array
  end
  # def parse_listed_dates(nokogiri_object)
  #   temp_array = []
  #   return_val = nokogiri_object.css('p.row span.itemdate').each {|i| temp_array << i.children.text}
  #   temp_array
  #
  #   prices = nokogiri_object.xpath('p.row span.itempp')
  # end

end

results = Scrape.new

returned = results.parse_results(cl_url)
puts results.parse_listed_dates(returned)
