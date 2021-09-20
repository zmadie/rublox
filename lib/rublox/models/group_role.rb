# frozen_string_literal: true

require "rublox/util/Errors"

module Rublox
  # @note This class is handled internally by the public interface such as
  #   {Group#roles}. You should not be creating it yourself.
  # The {GroupRole} class corresponds to a group's role. You can use it to get
  # and set information about roles.
  class GroupRole
    # @return [Integer] the role's ID
    attr_reader :id

    # @return [String] the role's name
    attr_reader :name

    # @return [String, nil] the role's description. Can be nil if the authenticated
    #   user does not have access to the group's role settings.
    attr_reader :description

    # @return [Integer] the role's rank (0-255)
    attr_reader :rank

    # @return [Integer] the count of how many users have the role
    attr_reader :member_count

    # @return [Group] the group tied to this role
    attr_reader :group

    # @param data [Hash]
    # @param group [FullGroup]
    # @param client [Client]
    def initialize(data, group, client)
      @id = data["id"]
      @name = data["name"]
      @description = data["description"]
      @rank = data["rank"]
      @member_count = data["memberCount"]
      @group = group

      @client = client
    end

    # @example
    #   client = Rublox::Client.new
    #   client.group_from_id(7384468)
    #   role = client
    #     .group_from_id(7384468)
    #     .member_by_id(1)
    #     .role
    #   puts role.rank # -> 1
    #   # Assume Roblox now has the Owner role
    #   updated_role = role.refresh
    #   puts updated_role.rank # -> 255
    # @return [GroupRole] a mirrored {GroupRole} object, containing new information
    #   about the role if it has been changed.
    def refresh
      data = @client.http_client.get(
        URL.endpoint("groups", "/v1/groups/#{@group.id}/roles")
      )["roles"].find { |role| role["id"] == @id }
      raise Errors::RoleNotFoundError.new(@id, @group.id) unless data

      GroupRole.new(
        data,
        @group,
        @client
      )
    end
  end
end
