# frozen_string_literal: true

# Tests for the Presence class
class PresenceTests < Test::Unit::TestCase
  def setup
    @client = Rublox::Client.new(ROBLOSECURITY)
  end

  def test_refresh
    assert_nothing_raised do
      @client.user_presence_from_id(1).user
    end
  end
end
