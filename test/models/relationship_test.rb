require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  
  def setup
    @relationship = Relationship.new(user_id: users(:one).id,
                                     word_id: words(:one).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a user_id" do
    @relationship.user_id = nil
    assert_not @relationship.valid?
  end

  test "should require a word_id" do
    @relationship.word_id = nil
    assert_not @relationship.valid?
  end

  test "should require points counter" do
    @relationship.points = nil
    assert_not @relationship.valid?
  end

  test "should have study_at" do
    @relationship.save
    assert_not @relationship.reload.study_at.nil?
  end

  test "should appropriately set points and study_at" do
    @relationship.save
    @relationship.study
    assert_equal 1, @relationship.points
    assert_equal Date.current + 2, @relationship.study_at
    @relationship.study("know")
    assert_equal 5, @relationship.points
    assert_equal Date.current + 7, @relationship.study_at
    @relationship.study("easy")
    assert_equal 6, @relationship.points
    assert_equal Date.current + 11, @relationship.study_at
    @relationship.study("nope")
    assert_equal 0, @relationship.points
    assert_equal Date.current + 1, @relationship.study_at
  end

end
