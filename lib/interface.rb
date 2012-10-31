class Interface
  
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

