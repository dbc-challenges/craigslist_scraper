require '../spec/spec_helper.rb'

class Controller

	def initialize(user_parameters = [1,"cars",2,2000,1])
		@user_parameters = user_parameters
		start
	end

	def start
		#1 : generate query string
		user_id = @user_parameters[0]
		content = @user_parameters[1]
		min = @user_parameters[2]
		max = @user_parameters[3]
		pic = @user_parameters[4]
		# insert into users(first_name,last_name,email_address) values("hello","myuser","bloopbleep@gmail.com");
		my_query = Query.new(content, min, max, pic)
		#2 : generate list of search results
		my_posts = SearchResult.new("http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1")
		nokogiri_results = my_posts.parse_results
		my_posts.create_posts_list(nokogiri_results)
		#3 : write to the database
		my_database = CLDatabase.new
		# inserting query
		my_database.insert_query(my_query.to_hash, user_id)
		# inserting junction and posts
		my_posts.postings.each do |post|
			my_database.insert_posts_users(post.data["posting_ID"], user_id)
			my_database.insert_post(post.data)	
		end
		my_database.get_user_posts(1)
		# my_database.insert_user(my_user.to_hash)
	end

	# def connect_the_dots
	# 	DatesPostsQueries.new(my_posts, user_id)
	# end
end

my_controller = Controller.new
#todo : 

#1: retrieve user ID
#2: 
# my_user = User.new("Apollo", "Creed", "apollocreed@gmail.com", "2012-10-30 20:21:31 -0700")