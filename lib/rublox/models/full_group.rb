# frozen_string_literal: true

require "rublox/models/group_shout"
require "rublox/models/limited_user"
require "rublox/derive/group"

module Rublox
  # @note This class is handled internally by the public interface such as
  #   {Client#group_from_id}. You should not be creating it yourself.
  # The {FullGroup} class corresponds to a full group response you can get via
  # https://groups.roblox.com/v1/groups/groupId. You can use it to get information
  # about groups.
  #
  # See {Group} for methods you can call on groups!
  class FullGroup
    include Group

    # @return [Integer] the group's ID
    attr_reader :id

    # @return [String] the group's name
    attr_reader :name

    # @return [String] the group's description
    attr_reader :description

    # @return [LimitedUser, nil] the group's owner, can be nil if the group has
    #   no owner
    attr_reader :owner

    # @return [GroupShout, nil] the group's shout, can be nil if the group has
    #   no shout
    attr_reader :shout

    # @return [Integer] the count of how many members the group has
    attr_reader :member_count

    # @return [true, false] is the group locked?
    attr_reader :locked

    # @return [true, false] is the group private/invite only?
    attr_reader :private

    # @param data [Hash]
    # @param client [Client]
    def initialize(data, client)
      @id = data["id"]
      @name = data["name"]
      @description = data["description"]
      @owner = LimitedUser.new(data["owner"], client) if data["owner"]
      @shout = GroupShout.new(data["shout"], client, @id) if data["shout"]
      @member_count = data["memberCount"]
      # isLocked is only returned if the group is locked, else it is just null (awesome)
      @locked = !data["isLocked"].nil?
      @private = data["publicEntryAllowed"]

      @client = client
    end
  end
end
