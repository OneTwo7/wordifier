require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    user_id = users(:one).id
    post_id = comments(:one).id
    @comment = Comment.new(
      user_id: user_id,
      post_id: post_id,
      content: "content"
    )
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user_id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "post_id should be present" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.content = "      "
    assert_not @comment.valid?
  end

  test "content shouldn't be too long" do
    @comment.content = "a" * 256
    assert_not @comment.valid?
  end

  test "content shouldn't be too short" do
    @comment.content = "a"
    assert_not @comment.valid?
  end

end
