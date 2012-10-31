

class Post
  attr_reader :data

  def initialize(input)
    @data = {"posting_ID" => input[0],
             "title" => input[1], 
             "price" => input[2],
             "location" => input[3], 
             "category" => input[4],
             "date_posted" => input[5],
             "unique_url" => input[6]}

  end

  def format_for_db
    {:posts => @data}
  end



end

#date posted - CHECK
#posting title - 
#listing price
#location
#category
#unique url

# [" Oct 29", "1999 Dodge Ram 1500 Quad Cab 5.9L V8", " $5995", 
#   " (milpitas)", " cars & trucks - by dealer", 
#   "http://sfbay.craigslist.org/sby/ctd/3372616665.html"]