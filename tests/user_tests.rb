# frozen_string_literal: true

# Tests for the User module
class UserTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  # Check if all methods don't raise anything
  def test_refresh
    assert_nothing_raised do
      @client.user_from_id(1).refresh
    end
  end

  def test_friend_count
    assert_nothing_raised do
      @client.user_from_id(1).friend_count
    end
  end

  def test_follower_count
    assert_nothing_raised do
      @client.user_from_id(1).follower_count
    end
  end

  def test_followings_count
    assert_nothing_raised do
      @client.user_from_id(1).followings_count
    end
  end

  def test_status
    assert_nothing_raised do
      @client.user_from_id(1).status
    end
  end

  def test_presence
    assert_nothing_raised do
      @client.user_from_id(1).presence
    end
  end
end
