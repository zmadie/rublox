# frozen_string_literal: true

require "time"

require "rublox/derive/user"

module Rublox
  # @note This class is handled internally by the public interface such as
  #   {FullGroup#owner}. You should not be creating it yourself.
  # The {LimitedUser} is an user containing less information. It exists as some
  # API's do not return full user information, and I decided to not send extra
  # requests. You can call {#refresh} to get a {FullUser} if needed.
  class LimitedUser
    include User

    # (see FullUser#id)
    attr_reader :id

    # (see FullUser#username)
    attr_reader :username

    # (see FullUser#display_name)
    attr_reader :display_name

    # (see FullUser#initialize)
    def initialize(data, client)
      @id = data["id"] || data["userId"] || data["builderId"]
      @username = data["name"] || data["username"] || data["builder"]
      @display_name = data["displayName"] || data["DisplayName"]

      @client = client
    end
  end
end
