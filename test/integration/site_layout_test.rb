require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin      = users(:one)
    @other      = users(:two)
    @word       = words(:one)
    @post       = posts(:one)
    @first_post = posts(:post_9)
    @com_1      = comments(:one)
    @com_2      = comments(:two)
  end
  
  test "layout links" do  	
  	get root_path
  	assert_template "static_pages/home"
  	assert_select "a[href=?]", root_path
  	assert_select "a[href=?]", help_path
  	assert_select "a[href=?]", about_path
  	assert_select "a[href=?]", contact_path
  	assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", words_path
    assert_select "a[href=?]", posts_path
  	get contact_path
  	assert_select "title", get_title("Contact")
  	get signup_path
  	assert_select "title", get_title("Sign up")
    get root_path
    assert_select "title", get_title
    log_in_as(@other)
    get root_path
    assert_select "a[href=?]", users_path, count: 0
    log_in_as(@admin)
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", posts_path
  end

  test "words links" do
    get root_path
    assert_select "a[href=?]", new_word_path, count: 0
    log_in_as(@other)
    get root_path
    assert_select "a[href=?]", new_word_path
    get words_path
    word = Word.paginate(page: 1).first
    assert_select "a[href=?]", word_path(word)
    assert_select "a[href=?]", edit_word_path(word), count: 0
    assert_select "a[href=?][method=?]", word_path(word), "delete", count: 0
    log_in_as(@admin)
    get root_path
    assert_select "a[href=?]", words_path
    get words_path
    assert_select "a[href=?]", edit_word_path(word)
    assert_select "a[href=?][data-method=?]", word_path(word), "delete"
  end

  test "words index links" do
    get words_path
    assert_select "nav#words-list-nav", count: 0
    log_in_as(@other)
    get words_path
    assert_select "nav#words-list-nav"
  end

  test "posts links" do
    get posts_path
    assert_select "form#new_post", count: 0
    assert_select "a[href=?]", edit_post_path(@first_post), count: 0
    assert_select "a[href=?][data-method=?]", post_path(@first_post), "delete", count: 0
    log_in_as(@other)
    get posts_path
    assert_select "form#new_post", count: 0
    assert_select "a[href=?]", edit_post_path(@first_post), count: 0
    assert_select "a[href=?][data-method=?]", post_path(@first_post), "delete", count: 0
    log_in_as(@admin)
    get posts_path
    assert_select "form#new_post"
    assert_select "a[href=?]", edit_post_path(@first_post)
    assert_select "a[href=?][data-method=?]", post_path(@first_post), "delete"
  end

  test "posts index links" do
    get post_path(@post)
    assert_select "form#new_comment", count: 0
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_1), count: 0
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_1),
                  "delete", count: 0
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_2), count: 0
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_2),
                  "delete", count: 0
    log_in_as(@other)
    get post_path(@post)
    assert_select "form#new_comment"
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_1), count: 0
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_1),
                  "delete", count: 0
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_2)
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_2),
                  "delete"
    log_in_as(@admin)
    get post_path(@post)
    assert_select "form#new_comment"
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_1)
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_1),
                  "delete"
    assert_select "a[href=?]", edit_post_comment_path(@post, @com_2)
    assert_select "a[href=?][data-method=?]", post_comment_path(@post, @com_2),
                  "delete"
  end

end
