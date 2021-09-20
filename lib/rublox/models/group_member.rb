# frozen_string_literal: true

module Rublox
  # @note This class is handled internally by the public interface such as
  #   such as {Group#member_by_user}. You should not be creating it yourself.
  # The {GroupMember} class corresponds to a member response, which contains
  # information about the user, their role and group.
  class GroupMember
    # @return [LimitedUser] the user object tied to this member
    attr_reader :user

    # @return {GroupRole} the role object tied to this member
    attr_reader :role

    # @return [FullGroup] the group object tied to this member
    attr_reader :group

    # @param user [FullUser, LimitedUser]
    # @param role [GroupRole]
    # @param group [FullGroup]
    # @param client [Client]
    def initialize(user, role, group, client)
      @user = user
      @role = role
      @group = group
      @client = client
    end

    # @note Use this if you need the state of the member changed. If you only
    #   want the role's state updated without updating the member's state, use
    #   {GroupRole#refresh}
    # @example
    #   client = Rublox::Client.new
    #   group = client.group_from_id(7384468)
    #   member = group.member_by_id(1)
    #   puts member.role.rank # -> 1
    #   # Assume Roblox now has the Owner role
    #   updated_member = member.refresh_role
    #   puts updated_member.role.rank # -> 255
    # @return [GroupMember] a new {GroupMember} with a new {#role}, if it has been changed.
    def refresh_role
      data = @client.http_client.get(
        URL.endpoint("groups", "/v2/users/#{@user.id}/groups/roles")
      )["data"].find { |role| role["group"]["id"] == @group.id }

      GroupMember.new(
        @user,
        GroupRole.new(data["role"], @group, @client),
        @group,
        @client
      )
    end
  end
end
