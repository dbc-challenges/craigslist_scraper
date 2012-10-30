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
    nokogiri_object.css('span.itemdate').each {|i| temp_array << i.children.text}
    # p temp_array.length
    temp_array
  end

  def parse_posting_title(nokogiri_object)
    temp_array = []
    nokogiri_object.css('span.itemsep+a').each { |i| temp_array << i.text}
    # p temp_array.length a[href*="html"]
    temp_array
  end

  def parse_posting_price(nokogiri_object)
    temp_array = []
    nokogiri_object.css('.itempp').each { |i| temp_array << i.inner_html}
    # p temp_array.length
    temp_array
  end

  def parse_location(nokogiri_object)
    temp_array = []
    nokogiri_object.css('.itempn').each { |i| temp_array << i.text}
    # p temp_array.length  
    temp_array
  end

  def parse_category(nokogiri_object)
    temp_array = []
    nokogiri_object.css('a:only-child').each { |i| temp_array << i.text}
    # p temp_array.length .itemcg
    temp_array
  end

  def parse_unique_url(nokogiri_object)
    temp_array = []
    nokogiri_object.css('span.itemsep+a').each { |i| temp_array << i['href']}
    # p temp_array.length
    temp_array
  end

  def parse_posting(nokogiri_object)
    nokogiri_object.css('p').each do |posting|
      posting_contents = []
      posting_contents << parse_listed_dates(posting).join
      posting_contents << parse_posting_title(posting).join
      posting_contents << parse_posting_price(posting).join
      posting_contents << parse_location(posting).join
      posting_contents << parse_category(posting).join
      posting_contents << parse_unique_url(posting).join
      p posting_contents
    end
  end

end

#      Nokogiri::HTML(open("#{cl_url}"))
#date posted - CHECK
#posting title - 
#listing price
#location
#category
#unique url

