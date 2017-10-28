require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:one)
    @other = users(:two)
    @word  = words(:one)
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

end
