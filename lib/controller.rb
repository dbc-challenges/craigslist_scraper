require '../spec/spec_helper.rb'

class Controller

	def initialize
		load_interface
	end

	def load_interface
		interface = Interface.new
		interface.greet
		@user_parameters = interface.new_query
		start
	end

	def start
		load_interface
		user_id = @user_parameters[0]
		email = @user_parameters[1]
		content = @user_parameters[2]
		min = @user_parameters[3]
		max = @user_parameters[4]
		pic = @user_parameters[5]
		my_query = Query.new(content, min, max, pic)
		
		# real search
		# my_posts = SearchResult.new(Query.new(content,min,max,pic)) 
		
		#spoofed search results
		
		my_posts = SearchResult.new("http://sfbay.craigslist.org/search/sss?query=1999+toyota+tundra&srchType=A&minAsk=500&maxAsk=9000&hasPic=1")
		nokogiri_results = my_posts.parse_results
		my_posts.create_posts_list(nokogiri_results)
		my_database = CLDatabase.new
		my_database.insert_query(my_query.to_hash, user_id)
		my_posts.postings.each do |post|
			my_database.insert_posts_users(post.data["posting_ID"], user_id)
			my_database.insert_post(post.data)	
		end
		my_database.get_user_posts(1)

		mail = Email.new(user_id)
		mail.run_mailer
	end

end

my_controller = Controller.new
