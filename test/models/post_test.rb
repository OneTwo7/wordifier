require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    id = users(:one).id
    @post = Post.new(user_id: id, title: "title", content: "content")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "title should be present" do
    @post.title = "      "
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "      "
    assert_not @post.valid?
  end

  test "title shouldn't be too short" do
    @post.title = "a" * 2
    assert_not @post.valid?
  end

  test "title shouldn't be too long" do
    @post.title = "a" * 55
    assert_not @post.valid?
  end

  test "content shouldn't be too short" do
    @post.content = "a" * 5
    assert_not @post.valid?
  end

end
