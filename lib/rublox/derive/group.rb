# frozen_string_literal: true

require "rublox/models/group_member"
require "rublox/models/group_role"

module Rublox
  # This mixin module contains functions that can be called on group objects.
  # @abstract
  module Group
    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(1)
    #   group.roles.each { |role| puts role.rank } # 0, 1, 180, 100, 254, 255
    # @return [Array<GroupRole>] the group's roles
    def roles
      @client.http_client.get(
        URL.endpoint("groups", "v1/groups/#{@id}/roles")
      )["roles"].map { |role| GroupRole.new(role, self, @client) }
    end

    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(7384468)
    #   member = group.member_by_id(1)
    #   puts member.role.rank # -> 1
    # @param id [Integer] the user's ID
    # @return [GroupMember] the user as a group member object
    def member_by_id(id)
      member_by_user(@client.user_from_id(id))
    rescue Errors::UserNotFoundError
      raise Errors::MemberNotFoundError.new(id, @id)
    end

    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(7384468)
    #   owner_member = group.member_by_user(group.owner)
    #   puts owner_member.role.rank # -> 255
    # @param user [FullUser, LimitedUser] the user to tie to the group member
    # @return [GroupMember] the user as a group member object
    def member_by_user(user)
      data = @client.http_client.get(
        URL.endpoint("groups", "v2/users/#{user.id}/groups/roles")
      )["data"].find { |member_data| member_data["group"]["id"] == @id }
      raise Errors::MemberNotFoundError.new(user.id, @id) unless data

      GroupMember.new(user, GroupRole.new(data["role"], self, @client), self, @client)
    end
  end
end
