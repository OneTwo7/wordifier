require 'test_helper'

class UserWordsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @word = words(:one)
    log_in_as(@user)
  end

  test "words page" do
    get words_user_path(@user)
    assert_not @user.words.empty?
    assert_match @user.words.count.to_s, response.body
    @user.words.each do |word|
      assert_select "a[href=?]", word_path(word)
    end
  end

  test "should add a word the standard way" do
    assert_difference '@user.words.count', 1 do
      post relationships_path, params: { word_id: @word.id }
    end
  end

  test "should add a word with Ajax" do
    assert_difference '@user.words.count', 1 do
      post relationships_path, xhr: true, params: { word_id: @word.id }
    end
  end

  test "should remove a word the standard way" do
    @user.add(@word)
    relationship = @user.relationships.find_by(word_id: @word.id)
    assert_difference '@user.words.count', -1 do
      delete relationship_path(relationship)
    end
  end

  test "should remove a word with Ajax" do
    @user.add(@word)
    relationship = @user.relationships.find_by(word_id: @word.id)
    assert_difference '@user.words.count', -1 do
      delete relationship_path(relationship), xhr: true
    end
  end

end
