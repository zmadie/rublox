# frozen_string_literal: true

require "http"

require "rublox/version"
require "rublox/util/http_client"
require "rublox/util/cache"
require "rublox/models/full_user"
require "rublox/models/full_group"
require "rublox/models/presence"

# rublox is a Roblox web API wrapper written in Ruby. It aims to provide an
# object oriented interface to get and modify data from Roblox's web API.
#
# Repository: https://github.com/roblox-api-wrappers/rublox
#
# Docs: https://rubydoc.info/gems/rublox
module Rublox
  # The {Client} object is the gateway to the API. Tt supplies methods that
  # return classes modeled after the interactions you can do with the API.
  #
  # Initialize the client with a .ROBLOSECURITY cookie if you need functionality
  # that requires it.
  # @example
  #   require "rublox"
  #   # without a cookie
  #   client = Rublox::Client.new
  #   # with a cookie
  #   client = Rublox::Client.new("_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this ...")
  class Client
    # @note The HTTP client should only be used when there are no methods
    #   provided by the library to achieve what you want.
    # @return [HTTPClient]
    attr_reader :http_client

    # Initialize the client with a .ROBLOSECURITY cookie if you require functionality
    # that needs it.
    # @example
    #   require "rublox"
    #   # without a cookie
    #   client = Rublox::Client.new
    #   # with a cookie
    #   client = Rublox::Client.new("_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this ...")
    # @param roblosecurity [String, nil] a valid .ROBLOSECURITY cookie
    def initialize(roblosecurity = "")
      @http_client = HTTPClient.new(roblosecurity)
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.username # -> Roblox
    # @param id [Integer] the user's ID
    # @return [FullUser] a model of the user specified by the ID
    def user_from_id(id)
      user = Cache.get(Cache::USER, id)
      return user if user

      data = @http_client.get(
        URL.endpoint("users", "v1/users/#{id}")
      )
    rescue Errors::UnhandledStatusCodeError
      raise Errors::UserNotFoundError, id
    else
      user = FullUser.new(
        data,
        self
      )
      Cache.set(Cache::USER, id, user)

      user
    end

    # @note This method sends 2 requests, use {#user_from_id} if possible.
    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_username("Roblox")
    #   puts user.id # -> 1
    # @param username [String] the user's username
    # @return [FullUser] a model of the user specified by the ID
    def user_from_username(username)
      data = @http_client.post(
        URL.endpoint("users", "/v1/usernames/users"),
        json: {
          usernames: [username],
          excludeBannedUsers: false
        }
      )["data"]
      raise Errors::UserNotFoundError.new(nil, username) if data.empty?

      user_from_id(
        data[0]["id"]
      )
    end

    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(1)
    #   puts group.name # -> RobloHunks
    # @param id [Integer] the groups's ID
    # @return [FullGroup] a model of the group specified by the ID
    def group_from_id(id)
      group = Cache.get(Cache::GROUP, id)
      return group if group

      data = @http_client.get(
        URL.endpoint("groups", "v1/groups/#{id}")
      )
    rescue Errors::UnhandledStatusCodeError
      raise Errors::GroupNotFoundError, id
    else
      group = FullGroup.new(data, self)
      Cache.set(Cache::GROUP, id, group)

      group
    end

    # @param id [Integer] the user's ID
    # @return [Presence] a model of the presence specified by the user's ID
    def user_presence_from_id(id)
      data = http_client.post(
        URL.endpoint("presence", "v1/presence/users"),
        json: {
          userIds: [id]
        }
      )
    rescue Errors::UnhandledStatusCodeError
      raise Errors::PresenceNotFoundError, id
    else
      Presence.new(
        data["userPresences"][0],
        self
      )
    end
  end
end
