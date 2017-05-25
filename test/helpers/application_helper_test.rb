require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

	test "get title helper" do
  	assert_equal get_title, 				"Words"
  	assert_equal get_title("Help"), "Help | Words"
  end

end