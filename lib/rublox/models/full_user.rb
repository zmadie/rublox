# frozen_string_literal: true

require "time"

require "rublox/derive/user"

module Rublox
  # @note This class is handled internally by the public interface such as
  #   {Client#user_from_id}. You should not be creating it yourself.
  # The {FullUser} class corresponds to a full user response you can get via
  # https://users.roblox.com/v1/users/userId. You can use it to get information
  # about users.
  #
  # See {User} for methods you can call on users!
  class FullUser
    include User

    # @return [Integer] the user's ID
    attr_reader :id

    # @return [String] the user's username
    attr_reader :username

    # @return [String] the user's display name
    attr_reader :display_name

    # @return [String] the user's profile description
    attr_reader :description

    # @return [true, false] is the user banned?
    attr_reader :banned

    # @return [Time] the user's join date
    attr_reader :join_date

    # @param data [Hash]
    # @param client [Client]
    def initialize(data, client)
      @id = data["id"]
      @username = data["name"]
      @display_name = data["displayName"]
      @description = data["description"]
      @banned = data["banned"]
      @join_date = Time.iso8601(data["created"])

      @client = client
    end
  end
end
