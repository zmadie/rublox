# frozen_string_literal: true

# Tests for the HTTPClient class
class HTTPClienTests < Test::Unit::TestCase
  def setup
    @no_auth_http_client = Rublox::Client.new.http_client
    @auth_http_client = Rublox::Client.new(ROBLOSECURITY).http_client
  end

  # Test if status codes not handled by the HTTPClient raises UnhandledStatusCodeError
  def test_request_errors
    assert_raise Rublox::Errors::UnhandledStatusCodeError do
      @no_auth_http_client.get("https://users.roblox.com/v1/users/")
    end
  end

  # Test if using an API that requires authentication without a .ROBLOSECURITY
  # cookie raises InvalidROBLOSECURITYError
  def test_roblosecurity_no_auth
    assert_raise Rublox::Errors::InvalidROBLOSECURITYError do
      @no_auth_http_client.get("https://users.roblox.com//v1/users/authenticated")
    end
  end

  # Test if using an API that requires authentication with a .ROBLOSECURITY does
  # not raise
  def test_roblosecurity_auth
    assert_nothing_raised do
      @auth_http_client.get("https://users.roblox.com/v1/users/authenticated")
    end
  end
end
