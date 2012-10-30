require 'json'

class Post
  attr_reader :post_data

  def initialize(input)
    @post_data = input
  end

  def self.from_json(json_object)
    deserialized_object = JSON.parse json_object
    temp = Post.new(deserialized_object)
    temp
  end

  def write_to_json
    JSON.generate(@post_data)
  end

end