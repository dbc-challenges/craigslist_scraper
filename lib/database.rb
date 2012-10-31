require 'fileutils'
require 'sqlite3'
require 'faker'
require 'date'

class CLDatabase

  attr_reader :file_name
  attr_accessor :craigslist_db

  def initialize(file_name = "craigslist_scraper.db")
    @file_name = file_name

    rows = run <<-SQL
      create table if not exists queries (
        id integer PRIMARY KEY AUTOINCREMENT,
        query varchar(200),
        user_id integer,
        max integer,
        min integer,
        content text,
        created_at DATETIME
      );
    SQL

    run <<-SQL
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

    run <<-SQL
      create table if not exists users  (
        id integer PRIMARY KEY AUTOINCREMENT,
        first_name varchar(50),
        last_name varchar(50),
        email_address varchar(50),
        account_creation_date DATETIME
      );
    SQL

    run <<-SQL
      create table if not exists dates_posts_queries  (
        user_id integer,
        post_id integer,
        PRIMARY KEY (user_id, post_id)
      );
    SQL
  end

  def run(query, *params)
    puts query
    database.execute(query, *params)
  end

  def insert_query(query_hash,user_id)
    run(
      "INSERT INTO queries
      (query, created_at, user_id)
      VALUES (?, ?, ?)",
      query_hash["queries"]["url"],
      query_hash["queries"]["created_at"],
      user_id
      )
  end

  def insert_post(post_hash)
    begin
      run(
        "INSERT INTO posts
        (posting_ID, title, price, location, category, date_posted, unique_URL)
        VALUES (?, ?, ?, ?, ?, ?, ?)",
        post_hash["posting_ID"],
        post_hash["title"],
        post_hash["price"],
        post_hash["location"],
        post_hash["category"],
        post_hash["date_posted"],
        post_hash["unique_URL"]
      )
    rescue
      # puts "hello"
    end
  end

  def insert_user(user_hash)
    run(
      "INSERT INTO users
      (first_name, last_name, email_address, account_creation_date)
      VALUES (?, ?, ?, ?)",
      user_hash["users"]["first_name"],
      user_hash["users"]["last_name"],
      user_hash["users"]["email_address"],
      user_hash["users"]["account_creation_date"]
      ) 
  end

  def insert_posts_users(posting_ID, user_ID)
    begin
      run(
        "INSERT INTO dates_posts_queries
        (user_id, post_id)
        VALUES (?, ?)",
        user_ID,
        posting_ID
        )
  rescue
    #something
  end
  end

  def get_user_posts(user_id)
    user_data = {}
    user_data["posts"] = run("select * from posts p, dates_posts_queries d where #{user_id} = d.user_id and p.posting_ID = d.post_ID")
    user_data["email_address"] = run("select email_address from users where id = #{user_id}")
    user_data
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
