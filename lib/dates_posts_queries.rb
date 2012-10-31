class DatesPostsQueries
	attr_reader 

	def initialize(posts, user_id)
		@posts = posts
		@user_id = user_id
		@hash_array = []
		@db = CLDatabase.new
	end

	# @posts.each do |post|
	# 	@db.insert_dates_posts_queries({ "user_id" => user_id, "post_id" => post.posting_ID}) 
	# end

	def to_hash
		{"dates_posts_queries" => {"user_id" => user_id, "post_id" => post_id}}
	end
end