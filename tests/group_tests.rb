# frozen_string_literal: true

# Tests for the Group module
class GroupTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  def test_roles
    assert_nothing_raised do
      assert @client.group_from_id(1).roles.length == 6
    end
  end

  # Test if giving valid data doesn't raise errors
  def test_member_by_id_valid
    assert_nothing_raised do
      @client.group_from_id(7_384_468).member_by_id(1)
    end
  end

  def test_member_by_user_valid
    assert_nothing_raised do
      user = @client.user_from_id(1)
      @client.group_from_id(7_384_468).member_by_user(user)
    end
  end

  # Test if giving invalid data raises errors
  def test_member_by_id_invalid
    assert_raise Rublox::Errors::MemberNotFoundError do
      @client.group_from_id(1).member_by_id(INVALID_ID)
    end
  end

  def test_member_by_user_invalid
    assert_raise Rublox::Errors::MemberNotFoundError do
      user = @client.user_from_id(1)
      @client.group_from_id(1).member_by_id(user)
    end
  end
end
