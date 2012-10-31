require 'fileutils'
require 'sqlite3'
require 'faker'
require 'date'

class CLDatabase

  attr_reader :file_name
  attr_accessor :craigslist_db

  def initialize(file_name = "craigslist_scraper.db")
    @file_name = file_name

    rows = database.execute <<-SQL
      create table if not exists queries (
        id integer PRIMARY KEY AUTOINCREMENT,
        query varchar(200),
        user_id integer,
        created_at DATETIME
      );
    SQL

    database.execute <<-SQL
      create table if not exists posts  (
        posting_ID integer PRIMARY KEY,
        title varchar(200),
        price varchar(50),
        location varchar(50),
        category varchar(50),
        date_posted DATETIME,
        unique_URL varchar(100)
      );
    SQL

    database.execute <<-SQL
      create table if not exists users  (
        id integer PRIMARY KEY AUTOINCREMENT,
        first_name varchar(50),
        last_name varchar(50),
        email_address varchar(50),
        account_creation_date DATETIME
      );
    SQL

    database.execute <<-SQL
      create table if not exists dates_posts_queries  (
        id integer PRIMARY KEY AUTOINCREMENT,
        user_id integer,
        post_id integer,
        query_id integer,
        date_id DATETIME
      );
    SQL
  end

  def insert_query(query_hash)
    database.execute(
      "INSERT INTO queries
      (query, created_at, user_id)
      VALUES (?, ?, ?)",
      query_hash["queries"]["url"],
      query_hash["queries"]["created_at"],
      get_user_id(query_hash["queries"]["username"])
      )
  end

  def insert_post(post_hash)
    begin
      database.execute(
        "INSERT INTO posts
        (posting_ID, title, price, location, category, date_posted, unique_URL)
        VALUES (?, ?, ?, ?, ?, ?, ?)",
        post_hash["posts"]["posting_ID"],
        post_hash["posts"]["title"],
        post_hash["posts"]["price"],
        post_hash["posts"]["location"],
        post_hash["posts"]["category"],
        post_hash["posts"]["date_posted"],
        post_hash["posts"]["unique_URL"]
      )
    rescue
      # puts "hello"
    end
  end

  def insert_user(user_hash)
    database.execute(
      "INSERT INTO users
      (first_name, last_name, email_address, account_creation_date)
      VALUES (?, ?, ?, ?)",
      user_hash["users"]["first_name"],
      user_hash["users"]["last_name"],
      user_hash["users"]["email_address"],
      user_hash["users"]["account_creation_date"]
      ) 
  end

  def insert_dates_posts_queries
  end
# INSERT INTO user_groups (user_id,group_id) SELECT users.user_id, groups.group_id FROM users INNER JOIN groups ON 1=1

  def get_user_id(user_name)
    # tbd
    17
  end

  def database
    @craigslist_db ||= SQLite3::Database.new file_name
  end

def no_duplicates?
db.insert_post if db.no_duplicates?

end
# title, price, location, category, date posted, unique URL
# title : "string" : "little girls bike"
# price : "string" : "$5005"
# location : "string" : "wilmington"
# category : "string" : "auto parts & dealers"
# date posted : "string" : "Oct 28"
# unique url : "string" : "http://sfbay.craigslist.org/eby/bik/3374116435.html"
# format : array: ["something","something_else"]
end

db = CLDatabase.new

db.insert_post({"posts" => {"posting_ID" => 3375916191, "title" => "RED BICYCLE", "price" => "100", "location" => "San Francisco, CA", "category" => "bikes", "date_posted" => "2012-10-30 16:06:48 -0700", "unique_URL" => "http://sfbay.craigslist.org/search/sss?query=red+bicycle&srchType=A&minAsk=50&maxAsk=200&hasPic=1"}})
