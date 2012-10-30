require_relative 'spec_helper'
require 'json'

describe 'Post' do

  it "creates an instance of itself from a JSON object" do
    object = JSON.generate(["test1","test2",3])
    json_in = Post.from_json(object)
    json_in.should be_a(Post)
  end

  it "has the correct data when creating an instance from JSON" do
    test_array = ["test1","test2",3]
    object = JSON.generate test_array
    json_in = Post.from_json(object)
    json_in.post_data.should eq(test_array)
  end

  it "writes itself to a JSON object" do
    test_array = ["test1","test2",3]
    json_out = Post.new(test_array)
    json_out.write_to_json.should eq("[\"test1\",\"test2\",3]")
  end

end
