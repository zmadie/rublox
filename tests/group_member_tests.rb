# frozen_string_literal: true

# Tests for the GroupMember class
class GroupMemberTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  # Check if all methods don't raise anything
  def test_refresh_role
    assert_nothing_raised do
      group = @client.group_from_id(1)
      group.member_by_user(group.owner).refresh_role
    end
  end
end
