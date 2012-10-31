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
  
  def initialize 
    @user_input = []
    @email = ""
    @email_validation = ""
    @username = ""
    @content = ""
    @min_price = ""
    @max_price = ""
    @picture = 0
  end

  def greet
    puts "**************** WOOKIESEARCH_BETA ***************"
    puts "\n\n"
  end

  def get_username
    puts "Please enter your user ID:"
    @username = gets.chomp.downcase
    validate_username
  end

  def get_email
    puts "Please enter your email address"
    @email = gets.chomp
    verify_email
  end

  def verify_email
    puts "Please re-enter your email address"
    @email_validation = gets.chomp
    if @email == @email_validation 
      @user_input << @email 
    else
      puts "Email addresses did not match."
      get_email
    end
  end

  def validate_username
    if @username =~ /\d/ 
      @user_input << @username
    else
      puts "username must consist of digits only"; 
      get_username
    end
  end

  def new_query
    get_username
    get_email
    get_content
    get_min_price
    get_max_price
    get_picture_field
    p @user_input
  end

  def get_content
    puts "What would you like to search for on Craigslist?"
    @content = gets.chomp
    validate_content
  end

  def validate_content
    puts "You are searching for #{@content}. Is this correct(y/n)"
    validation = gets.chomp
    if validation.downcase == 'y'
      @user_input << @content
      return
    elsif validation.downcase == 'n'
      get_content
    else
      puts "I don't understand"
      get_content
    end
  end

  def get_min_price
    puts "What is your minimum price for #{@content}? (Do not enter a $)"
    @min_price = gets.chomp
    validate_min_price
  end

  def validate_min_price
    if @min_price =~ /^\d/
      verify_min_price
    else
      puts "Maximum price must be integers only"
      get_min_price
    end
  end

  def verify_min_price
    puts "Your minimum price for #{@content} is #{@min_price}. Is this correct(y/n)"
    validation = gets.chomp
    if validation.downcase == 'y'
      @user_input << @min_price
      return
    elsif validation.downcase == 'n'
      get_min_price
    else
      puts "I don't understand"
      get_min_price
    end
  end

  def get_max_price
    puts "What is your maximum price for #{@content} (Do not enter a $)?"
    @max_price = gets.chomp
    validate_max_price
  end

  def validate_max_price
    if @max_price =~ /^\d/
      verify_max_price
    else
      puts "Maximum price must be integers only"
      get_max_price
    end 
  end

  def verify_max_price
    puts "Your maximum price for #{@content} is $#{@max_price}. Is this correct(y/n)"
    validation = gets.chomp
    if validation.downcase == 'y'
      @user_input << @max_price
      return
    elsif validation.downcase == 'n'
      get_max_price
    else
      puts "I don't understand"
      get_max_price
    end
  end

  def get_picture_field
    puts "Do you only want postings for #{@content} with images?(y/n)"
    verify_picture_field
  end
    
  def verify_picture_field
    validation = gets.chomp
    if validation.downcase == 'y'
      @picture = 1
      @user_input << @picture
      return
    elsif validation.downcase == 'n'
      @user_input << @picture
    else
      puts "I don't understand"
      get_picture_field
    end
  end

end

interface = Interface.new
interface.greet
interface.new_query

