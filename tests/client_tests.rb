# frozen_string_literal: true

# Tests for the Client class
class ClientTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  # Test if giving valid data doesn't raise errors
  def test_get_user_from_id_valid
    assert_nothing_raised do
      @client.user_from_id(1)
    end
  end

  def test_get_user_from_username_valid
    assert_nothing_raised do
      @client.user_from_username("Roblox")
    end
  end

  def test_get_group_from_id_valid
    assert_nothing_raised do
      @client.group_from_id(1)
    end
  end

  def test_get_presence_from_id_valid
    assert_nothing_raised do
      @client.user_presence_from_id(1)
    end
  end

  # Test if giving invalid data raises errors
  def test_get_user_from_id_invalid
    assert_raise Rublox::Errors::UserNotFoundError do
      @client.user_from_id(INVALID_ID)
    end
  end

  def test_get_user_from_username_invalid
    assert_raise Rublox::Errors::UserNotFoundError do
      @client.user_from_username("a")
    end
  end

  def test_get_group_from_id_invalid
    assert_raise Rublox::Errors::GroupNotFoundError do
      @client.group_from_id(INVALID_ID)
    end
  end

  def test_get_presence_from_id_invalid
    assert_raise Rublox::Errors::PresenceNotFoundError do
      @client.user_presence_from_id(INVALID_ID)
    end
  end
end
