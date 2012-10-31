require '../spec/spec_helper.rb'

class IncrementalController
	def initialize(user = 1)
		@user = user
		@db = CLDatabase.new
	end

	def retrieve_posts
		user_data = @db.get_user_posts(@user)
	end

	def send_email
		 
	end

end

inc = IncrementalController.new
inc.retrieve_posts