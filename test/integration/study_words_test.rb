require 'test_helper'

class StudyWordsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    log_in_as(@user)
    @buttons = ["nope", "yeah", "easy", "know"]
  end

  test "should show study button while there are words to study" do
  	get root_path
  	assert_select "a[href=?]", study_path
  	@user.words.each do |word|
  		@user.relationships.find_by(word_id: word.id).study
  	end
  	get root_path
  	assert_select "a[href=?]", study_path, count: 0
  end

  test "should present correct study UI" do
  	get study_path
  	assert_select "h1", Word.find(session[:words_ids].first).word
  	@buttons.each do |button|
  		assert_select "a[href^=?]", study_path, text: button
  	end
  end

  test "should study words" do
  	get study_path
  	pars = {
  		"nope" => [0, 1],
  		"yeah" => [1, 2],
  		"easy" => [1, 3],
  		"know" => [5, 7]
  	}
  	ids = session[:words_ids]
  	len = ids.length
  	rel = @user.relationships.find_by(word_id: ids.first)
  	@buttons.each do |button|
  		get study_path(button: button)
  		rel.reload
  		assert_equal pars[button][0], rel.points
  		assert_equal Date.current + pars[button][1], rel.study_at
  		if session[:done].nil?
  			ids = session[:words_ids]
  			assert_equal len - 1, ids.length
  			assert_select "h1", Word.find(ids.first).word
  			len = ids.length
    		rel = @user.relationships.find_by(word_id: ids.first)
    	else
    		assert session[:words_ids].nil?
    		assert_select "p", "You studied all words for today"
  		end
  	end
  end

end
