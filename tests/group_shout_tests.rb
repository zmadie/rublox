# frozen_string_literal: true

# Tests for the GroupShout class
class GroupShoutTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  def test_refresh
    assert_nothing_raised do
      @client.group_from_id(5_555_555).shout.refresh
    end
  end
end
