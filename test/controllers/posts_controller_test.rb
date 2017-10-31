require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:one)
    @other = users(:two)
    @post  = posts(:one)
    @params = {
      post: {
        user_id: @admin.id,
        title:   "new title",
        content: "new content"
      }
    }
  end
  
  test "should get index" do
    get posts_path
    assert_response :success
    assert_template "index"
    assert_select "title", get_title("News")
  end

  test "should show 10 posts on index page" do
    get posts_path
    assert_select "div.pagination", count: 2
    assert_select "ul.posts li", count: 10
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
    assert_template "show"
    assert_select "title", get_title(@post.title)
  end

  test "should redirect update when not logged in" do
    patch post_path(@post), params: @params
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to root_url
  end

  test "should create a post with xhr" do
    log_in_as(@admin)
    assert_difference 'Post.count', 1 do
      post posts_path, xhr: true, params: @params
    end
  end

  test "should create a post" do
    log_in_as(@admin)
    assert_difference 'Post.count', 1 do
      post posts_path, params: @params
    end
    assert_redirected_to posts_url
    assert_not flash.empty?
  end

  test "should update a post with xhr" do
    log_in_as(@admin)
    patch post_path(@post), params: @params, xhr: true
    @post.reload
    assert_equal "new title", @post.title
  end

  test "should update a post" do
    log_in_as(@admin)
    patch post_path(@post), params: @params
    assert_redirected_to posts_url
    assert_not flash.empty?
    @post.reload
    assert_equal "new title", @post.title
  end

  test "should destroy a post with xhr" do
    log_in_as(@admin)
    assert_difference 'Post.count', -1 do
      delete post_path(@post), xhr: true
    end
  end

  test "should destroy a post" do
    log_in_as(@admin)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to posts_url
  end

end
