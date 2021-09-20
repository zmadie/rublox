# frozen_string_literal: true

require "rublox/util/url"

module Rublox
  # This mixin module contains functions that can be called on user objects.
  # @abstract
  module User
    # @example Updating a {FullUser}
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.display_name # -> Roblox
    #   # suppose the Roblox account changes it's display name to "ABC"
    #   refreshed_user = user.refresh
    #   puts refreshed_user.display_name # -> ABC
    # @example Updating a {LimitedUser}
    #   client = Rublox::Client.new
    #   group = client.group_from_id(1)
    #   # say we want the user's join date. LimitedUsers do not contain that information, so we can update it to get a
    #   # FullUser, which has that
    #   the_full_user_owner = group.owner.refresh
    #   # we can now get the owner's join date
    #   puts the_full_user_owner.join_date.inspect # "2008-09-30 15:54:26 UTC"
    # @return [FullUser] a mirrored {FullUser} object, containing new information
    #   about theuser if it has been changed, or if the user is a {LimitedUser}.
    def refresh
      @client.user_from_id(@id)
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.friend_count # -> 0
    # @return [Integer] the count of how many friends the user has
    def friend_count
      @client.http_client.get(
        URL.endpoint("friends", "/v1/users/#{@id}/friends/count")
      )["count"]
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.follower_count # -> around 6 million
    # @return [Integer] the count of how many followers the user has
    def follower_count
      @client.http_client.get(
        URL.endpoint("friends", "/v1/users/#{@id}/followers/count")
      )["count"]
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.followings_count # -> 0
    # @return [Integer] the count of how many users the user has followed
    def followings_count
      @client.http_client.get(
        URL.endpoint("friends", "/v1/users/#{@id}/followings/count")
      )["count"]
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   puts user.status # -> "Welcome to Roblox, the Imagination Platform. Make friends, explore, and play games!"
    # @return [String] the user's status
    def status
      @client.http_client.get(
        URL.endpoint("users", "/v1/users/#{@id}/status")
      )["status"]
    end

    # @example
    #   client = Rublox::Client.new
    #   user = client.user_from_id(1)
    #   presence = user.presence
    #   puts presence.last_location # -> "Website"
    # @return [Presence] the presence state of the user
    def presence
      @client.user_presence_from_id(@id)
    end

    # @return [String] a readable string representation of the user
    def to_s
      "User of ID #{@id}, username: #{@username}"
    end
  end
end
