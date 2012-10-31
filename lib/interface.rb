class Interface

	def initialize
		start
	end

	def start
		puts "Welcome to Craigslist Scraper! Please enter a search string."
		content = "Red bike"
		puts "Please enter a minimum amount to be bid or nil if you do not want to enter a bid."
		min = "10"
		puts "Please enter a maximum amount to be bid or nil if you do not want to enter a bid."
		max = "100"
		puts "Please enter 1 if you'd like a picture or nil if you do not want to enter a bid."
		pic = "1"

		user_id = 1
		
		#1 : generate query string
		my_query = Query.new(content, min, max, pic)

		#2 : generate list of search results
		my_posts = SearchResult.new(my_query.url)

		my_user = User.new("Apollo", "Creed", "apollocreed@gmail.com", "2012-10-30 20:21:31 -0700")

		#3 : write to the database
		my_database = CLDatabase.new

		my_database.insert_query(my_query.to_hash)

		my_posts.each do |post|
			my_database.insert_post(post.data)	
		end
		
		my_database.insert_user(my_user.to_hash)
	end

	def connect_the_dots
		Dates_posts_queries.new(my_query, my_posts, user_id)
	end
end

#todo : 

#1: retrieve user ID
#2: 