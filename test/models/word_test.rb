require 'test_helper'

class WordTest < ActiveSupport::TestCase
  
  def setup
  	@word = Word.new(word: "A word", definition: "The definition",
  									 sentence: "A sentence")
  end

  test "should be valid" do
  	assert @word.valid?
  end

  test "word should be present" do
  	@word.word = "      "
  	assert_not @word.valid?
  end

  test "sentence should be present" do
  	@word.sentence = "      "
  	assert_not @word.valid?
  end

  test "definition should be present" do
  	@word.definition = "      "
  	assert_not @word.valid?
  end

  test "word shouldn't be too long" do
  	@word.word = "a" * 31
  	assert_not @word.valid?
  end

  test "sentence shouldn't be too long" do
  	@word.sentence = "a" * 251
  	assert_not @word.valid?
  end

  test "definition shouldn't be too long" do
  	@word.definition = "a" * 251
  	assert_not @word.valid?
  end

  test "words should be unique" do
    duplicate_word = @word.dup
    duplicate_word.word = @word.word.upcase
    @word.save
    assert_not duplicate_word.valid?
  end

  test "words should be saved as lower-case" do
    mixed_case_word = "A WoRd"
    @word.word = mixed_case_word
    @word.save
    assert_equal mixed_case_word.downcase, @word.reload.word
  end

end
