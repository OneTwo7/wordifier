require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

	test "get title helper" do
  	assert_equal get_title, 				"Wordifier"
  	assert_equal get_title("Help"), "Help | Wordifier"
  end

end