require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_url
    assert_response :success
    assert_template "home"
    assert_select "title", get_title
  end

  test "should get help" do
    get help_url
    assert_response :success
    assert_template "help"
    assert_select "title", get_title("Help")
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_template "about"
    assert_select "title", get_title("About")
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_template "contact"
    assert_select "title", get_title("Contact")
  end

end
