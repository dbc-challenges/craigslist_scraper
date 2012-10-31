require 'nokogiri'
require 'open-uri'
require_relative 'post.rb'

class InvalidQuery < Exception; end

class SearchResult

  attr_reader :postings

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
    temp_array
  end

  def parse_posting_title(nokogiri_object)
    temp_array = []
    nokogiri_object.css('span.itemsep+a').each { |i| temp_array << i.text}
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
    nokogiri_object.css('span.itemsep+a').each { |i| temp_array << i['href']}
    temp_array
  end

  def parse_unique_posting_id(nokogiri_object)
    temp_array = []
    nokogiri_object.css('span.itemsep+a').each { |i| temp_array << i['href'].slice(/\d{10}/) }
    temp_array
  end

  def parse_posting(nokogiri_object)
      parsed_search_results = []
      nokogiri_object.css('p').each do |posting|
      posting_contents = []
      posting_contents << parse_listed_dates(posting).join
      posting_contents << parse_posting_title(posting).join
      posting_contents << parse_posting_price(posting).join
      posting_contents << parse_location(posting).join
      posting_contents << parse_category(posting).join
      posting_contents << parse_unique_url(posting).join
      posting_contents << parse_unique_posting_id(posting).join
      parsed_search_results << posting_contents
    end
      parsed_search_results
  end

  def create_posts_list(nokogiri_object)
    parse_posting(nokogiri_object).each do |parsed_post|
      @postings << Post.new(parsed_post)
    end
  end

end


