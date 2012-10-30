require 'nokogiri'
require 'open-uri'

class InvalidQuery < Exception; end

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

  def parse_results(url)
    returned_page = Nokogiri::HTML(open(url))
  end

  def parse_listed_dates(nokogiri_object)
    temp_array = []
    nokogiri_object.css('p.row span.itemdate').each {|i| temp_array << i.children.text}
    temp_array
  end

  def parse_posting_title(nokogiri_object)
    temp_array = []
    nokogiri_object.css('p.row > a').each { |i| temp_array << i.inner_html}
    temp_array
  end

  def parse_posting_price(nokogiri_object)
    temp_array = []
    nokogiri_object.css('.itempp').each { |i| temp_array << i.inner_html}
    temp_array
  end

  def parse_location(nokogiri_object)
    temp_array = []
    nokogiri_object.css('.itempn').each { |i| temp_array << i.text}
    temp_array
  end

  def parse_category(nokogiri_object)
    temp_array = []
    nokogiri_object.css('.itemcg').each { |i| temp_array << i.text}
    temp_array
  end

  def parse_unique_url(nokogiri_object)
    temp_array = []
    nokogiri_object.css('p.row > a').each { |i| temp_array << i['href']}
    temp_array
  end

end

#      Nokogiri::HTML(open("#{cl_url}"))
#date posted - CHECK
#posting title - 
#listing price
#location
#category
#unique url

