# frozen_string_literal: true

require "rublox/models/limited_user"

module Rublox
  # @note This class is handled internally by the public interface such as
  #   {FullGroup#shout}. You should not be creating it yourself.
  # The {GroupShout} class corresponds to a shout response. You can use it to get
  # and set information about group shouts.
  class GroupShout
    # @return [String] the shout's body
    attr_reader :body

    # @return [LimitedUser, nil] the user that made the shout, can be nil if the
    #   shout has no poster
    attr_reader :poster

    # @param data [Hash]
    # @param client [Client]
    # @param group_id [Integer]
    def initialize(data, client, group_id)
      @body = data["body"]
      @poster = LimitedUser.new(data["poster"], client) if data["poster"]

      @group_id = group_id
      @client = client
    end

    # Sends a new shout.
    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(1)
    #   group.shout.send_shout("new shout")
    # @param new_shout [String] the body of the new shout
    # @return [void]
    def send_shout(new_shout)
      @client.http_client.patch(
        URL.endpoint("groups", "v1/groups/#{@group_id}/status"),
        json: {
          message: new_shout
        }
      )
    end

    # Clears the group shout. Same as calling {#send_shout} with an empty string.
    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(1)
    #   group.shout.clear
    #   # same as
    #   group.shout.send_shout("")
    # @return [void]
    def clear
      send_shout("")
    end

    # @return [GroupShout] A new group shout object with updated information.
    def refresh
      @client.group_from_id(@group_id).shout
    end
  end
end
