require 'test_helper'

class WordsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@word       = words(:one)
		@admin      = users(:one)
		@other      = users(:two)
	end

	test "should get words index" do
		get words_path
		assert_response :success
		assert_template "words/index"
		assert_select "title", get_title("Words List")
		assert_select 'div.pagination', count: 2
	end

	test "should get appropriate words lists" do
		log_in_as(@other)
		lists = %w[words words_to_study studied new_words known_words learned_words]
		lists.each do |list|
			get words_path(list: list)
			assert_response :success
			assert_template "words/index"
			assert_select "ul.words li", count: @other.send(list).count
		end
	end
  
	test "should get show word" do
		get word_path(@word)
		assert_response :success
		assert_template "show"
		assert_select "title", get_title("#{@word.word.capitalize}")
	end

	test "should redirect new if not logged in" do
		get new_word_path
		assert_redirected_to login_url
	end

	test "should get new word if logged in" do
		log_in_as(@other)
		get new_word_path
		assert_response :success
		assert_template "new"
		assert_select "title", get_title("New word")
	end

	test "should redirect edit if not logged in as admin" do
		log_in_as(@other)
		get edit_word_path(@word)
		assert_redirected_to root_url
	end

	test "should get edit word if logged in as admin" do
		log_in_as(@admin)
		get edit_word_path(@word)
		assert_response :success
		assert_template "edit"
		assert_select "title", get_title("Edit word")
	end

	test "should redirect create when not logged in" do
    post words_path, params: { word: { word:       @word.word,
                                       definition: @word.definition,
                                       sentence:   @word.sentence } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should create word" do
  	log_in_as(@other)
  	assert_difference 'Word.count', 1 do
	  	post words_path, params: { word: { word:       "another",
	                                       definition: "definition",
	                                       sentence:   "sentence" } }
	  end
    assert_not flash.empty?
    assert_redirected_to words_path
  end

  test "should redirect update when logged in as a non-admin" do
  	log_in_as(@other)
    patch word_path(@word), params: { word: { word:       @word.word,
                                       				definition: @word.definition,
                                       				sentence:   @word.sentence } }
    assert_redirected_to root_url
  end

  test "should update word" do
  	log_in_as(@admin)
  	definition = "another definition"
  	sentence   = "another sentence"
    patch word_path(@word), params: { word: { word:       @word.word,
                                       				definition: definition,
                                       				sentence:   sentence } }
    assert_not flash.empty?
    assert_redirected_to @word
    @word.reload
    assert_equal definition,  @word.definition
    assert_equal sentence,    @word.sentence
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other)
    assert_no_difference 'Word.count' do
      delete word_path(@word)
    end
    assert_redirected_to root_url
  end

  test "should delete word" do
    log_in_as(@admin)
    assert_difference 'Word.count', -1 do
      delete word_path(@word)
    end
    assert_not flash.empty?
    assert_redirected_to words_path
  end

end
