class Query
  attr_reader :content, :min, :max, :pic, :url_pieces

  def initialize(content, min, max, pic)
    @content = content.split(" ").join("+")
    @min = min
    @max = max
    @pic = pic
    @url_pieces = ["http://sfbay.craigslist.org/search/sss?query=#{@content}&srchType=A&", "minAsk=#{@min}&", "maxAsk=#{@max}", "&hasPic=#{@pic}"]
  end


  def url
    url_pieces[1] = "minAsk=&" if min == "nil"
    url_pieces[2] = "maxAsk=" if max == "nil"
    url_pieces[3] = "" if pic == "nil"
    url_pieces.join("")
  end
end
