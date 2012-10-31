require '../lib/post.rb'


describe 'Post' do

  it "creates a hash based on the data sent to it" do
    initialize_post = Post.new([" Oct 29", "1999 Dodge Ram 1500 Quad Cab 5.9L V8", " $5995", " (milpitas)", " cars & trucks - by dealer", "http://sfbay.craigslist.org/sby/ctd/3372616665.html"])
    initialize_post.data.should eq({:date => " Oct 29",
                                    :title => "1999 Dodge Ram 1500 Quad Cab 5.9L V8",
                                    :price => " $5995",
                                    :location => " (milpitas)",
                                    :category => " cars & trucks - by dealer",
                                    :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"})
  end

  it "formats post data for the database" do
    initialize_post = Post.new([" Oct 29", "1999 Dodge Ram 1500 Quad Cab 5.9L V8", " $5995", " (milpitas)", " cars & trucks - by dealer", "http://sfbay.craigslist.org/sby/ctd/3372616665.html"])
    initialize_post.format_for_db.should eq({:posts => {:date => " Oct 29",
                                    :title => "1999 Dodge Ram 1500 Quad Cab 5.9L V8",
                                    :price => " $5995",
                                    :location => " (milpitas)",
                                    :category => " cars & trucks - by dealer",
                                    :url => "http://sfbay.craigslist.org/sby/ctd/3372616665.html"}})
  end
end