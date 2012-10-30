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
      create table queries (
        id integer PRIMARY KEY AUTOINCREMENT,
        query varchar(200),
        user_id integer,
        created_at DATETIME,
        updated_at DATETIME
      );
    SQL

  end

  def insert_query(query_hash)
    database.execute
      "INSERT INTO queries
      (query, created_at, updated_at, user_id)
      VALUES (?, ?, ?, ?)",
      query_hash["queries"]["url"],
      query_hash["queries"]["created_at"],
      query_hash["queries"]["updated_at"],
      get_user_id(query_hash["queries"]["username"]
      )
  end

  def insert_post

  end

  def insert_user

  end

  def get_user_id(user_name)
    17
  end

  def database
    @craigslist_db ||= SQLite3::Database.new file_name
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