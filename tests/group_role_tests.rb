# frozen_string_literal: true

# Tests for the GroupRole class
class GroupRoleTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  # Check if all methods don't raise anything
  def test_refresh
    assert_nothing_raised do
      group = @client.group_from_id(1)
      group.member_by_user(group.owner).role.refresh
    end
  end
end
