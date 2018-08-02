require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:two)
    @post = posts(:one)
    @post_2 = posts(:two)
    @comment = comments(:two)
    @params = {
      comment: {
        user_id: @user.id,
        post_id: @post.id,
        content: "content"
      }
    }
  end

  test "should redirect actions when not logged in" do
    assert_no_difference 'Comment.count' do
      post post_comments_path(@post), params: @params
    end
    assert_not flash.empty?
    assert_redirected_to login_url
    get edit_post_comment_path(@post, @comment)
    assert_not flash.empty?
    assert_redirected_to login_url
    patch post_comment_path(@post, @comment), params: @params
    assert_not flash.empty?
    assert_redirected_to login_url
    assert_no_difference 'Comment.count' do
      delete post_comment_path(@post, @comment)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should create a comment" do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post post_comments_path(@post), params: @params
    end
    assert_not flash.empty?
    assert_redirected_to @post
  end

  test "should update a comment" do
    log_in_as(@user)
    new_content = "new content"
    @params[:comment][:content] = new_content
    patch post_comment_path(@post, @comment), params: @params, xhr: true
    @comment.reload
    assert_equal new_content, @comment.content
    assert flash.empty?
  end

  test "should destroy a comment" do
    log_in_as(@user)
    assert_difference 'Comment.count', -1 do
      delete post_comment_path(@post, @comment)
    end
    assert_not flash.empty?
    assert_redirected_to @post
  end

  test "should show 10 comments" do
    get post_path(@post_2)
    assert_select "ul.comments li", count: 10
  end

end
