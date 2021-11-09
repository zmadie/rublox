# frozen_string_literal: true

require "rublox/util/errors"

module Rublox
  # This class is used to set a role's permissions. It uses the builder pattern to assign permissions.
  # @example (see Rublox::RolePermissions#initialize)
  class RolePermissions # rubocop:disable Metrics/ClassLength
    # @!visibility private
    PERMISSIONS = {
      permissions: {
        DeleteFromWall: nil,
        PostToWall: nil,
        InviteMembers: nil,
        PostToStatus: nil,
        RemoveMembers: nil,
        ViewStatus: nil,
        ViewWall: nil,
        ChangeRank: nil,
        AdvertiseGroup: nil,
        ManageRelationships: nil,
        AddGroupPlaces: nil,
        ViewAuditLogs: nil,
        CreateItems: nil,
        ManageItems: nil,
        SpendGroupFunds: nil,
        ManageClan: nil,
        ManageGroupGames: nil,
        UseCloudAuthentication: nil,
        AdministerCloudAuthentication: nil
      }
    }.freeze

    # Initialize a RolePermissions object from an endpoint's data
    # @!visibility private
    # @param data [Hash]
    # @return [RolePermissions]
    def self.from_data(data) # rubocop:disable Metrics/AbcSize
      permissions_data = data["permissions"]
      group_posts_permissions = permissions_data["groupPostsPermissions"]
      group_membership_permissions = permissions_data["groupMembershipPermissions"]
      group_management_permissions = permissions_data["groupManagementPermissions"]
      group_economy_permissions = permissions_data["groupEconomyPermissions"]
      # group_open_cloud_permissions = permissions_data["groupOpenCloudPermissions"]

      object = new
      object._permissions = {
        permissions: {
          DeleteFromWall: group_posts_permissions["deleteFromWall"],
          PostToWall: group_posts_permissions["postToWall"],
          InviteMembers: group_membership_permissions["inviteMembers"],
          PostToStatus: group_posts_permissions["postToStatus"],
          RemoveMembers: group_membership_permissions["removeMembers"],
          ViewStatus: group_posts_permissions["viewStatus"],
          ViewWall: group_posts_permissions["viewWall"],
          ChangeRank: group_membership_permissions["changeRank"],
          AdvertiseGroup: group_economy_permissions["advertiseGroup"],
          ManageRelationships: group_management_permissions["manageRelationships"],
          AddGroupPlaces: group_economy_permissions["addGroupPlaces"],
          ViewAuditLogs: group_management_permissions["viewAuditLogs"],
          CreateItems: group_economy_permissions["createItems"],
          ManageItems: group_economy_permissions["manageItems"],
          SpendGroupFunds: group_economy_permissions["spendGroupFunds"],
          ManageClan: group_management_permissions["manageClan"],
          ManageGroupGames: group_economy_permissions["manageGroupGames"]
          # UseCloudAuthentication: group_open_cloud_permissions["useCloudAuthentication"],
          # AdministerCloudAuthentication: group_open_cloud_permissions["administerCloudAuthentication"]
        }
      }

      object
    end

    # @example
    #   # give permissions to view and delete messages from the group wall
    #   role_permissions = Rublox::RolePermissions.new
    #     .view_wall
    #     .delete_from_wall
    def initialize
      @permissions = PERMISSIONS.clone
    end

    # Private getter for permissions
    # @!visibility private
    # @return [Hash]
    def _permissions
      @permissions
    end

    # Private setter for permissions
    # @!visibility private
    # @return [nil]
    def _permissions=(value)
      @permissions = value
    end

    # Allow members with the role to view the group wall
    # @return [RolePermissions]
    def delete_from_wall
      @permissions[:permissions][:DeleteFromWall] = true
      self
    end

    # Allow members with the role to invite members
    # @return [RolePermissions]
    def invite_members
      @permissions[:permissions][:InviteMembers] = true
      self
    end

    # Allow members with the role to post to the group's status
    # @return [RolePermissions]
    def post_to_status
      @permissions[:permissions][:PostToStatus] = true
      self
    end

    # Allow members with the role to remove members
    # @return [RolePermissions]
    def remove_members
      @permissions[:permissions][:RemoveMembers] = true
      self
    end

    # Allow members with the role to view the group's status
    # @return [RolePermissions]
    def view_status
      @permissions[:permissions][:ViewStatus] = true
      self
    end

    # Allow members with the role to view the group's wall
    # @return [RolePermissions]
    def view_wall
      @permissions[:permissions][:ViewWall] = true
      self
    end

    # Allow members with the role to change the rank of other members
    # @return [RolePermissions]
    def change_rank
      @permissions[:permissions][:ChangeRank] = true
      self
    end

    # Allow members with the role to advertise the group
    # @return [RolePermissions]
    def advertise_group
      @permissions[:permissions][:AdvertiseGroup] = true
      self
    end

    # Allow members with the role to manage the group's relationships with other groups
    # @return [RolePermissions]
    def manage_relationships
      @permissions[:permissions][:ManageRelationships] = true
      self
    end

    # Allow members with the role to create group places
    # @return [RolePermissions]
    def add_group_places
      @permissions[:permissions][:AddGroupPlaces] = true
      self
    end

    # Allow members with the role to view audit logs
    # @return [RolePermissions]
    def view_audit_logs
      @permissions[:permissions][:ViewAuditLogs] = true
      self
    end

    # Allow members with the role to create items
    # @return [RolePermissions]
    def create_items
      @permissions[:permissions][:ViewStatus] = true
      self
    end

    # Allow members with the role to manage items
    # @return [RolePermissions]
    def manage_items
      @permissions[:permissions][:ViewStatus] = true
      self
    end

    # Allow members with the role to spend group funds
    # @return [RolePermissions]
    def spend_group_funds
      @permissions[:permissions][:SpendGroupFunds] = true
      self
    end

    # Allow members with the role to manage the clan
    # @return [RolePermissions]
    def manage_clan
      @permissions[:permissions][:ManageClan] = true
      self
    end

    # Allow members with the role to manage group games
    # @return [RolePermissions]
    def manage_group_games
      @permissions[:permissions][:ManageGroupGames] = true
      self
    end

    # @!visibility private
    # @todo find out what this does (open cloud?)
    # @return [RolePermissions]
    def use_cloud_authentication
      @permissions[:permissions][:UseCloudAuthentication] = true
      self
    end

    # (see #use_cloud_authentication)
    def administer_cloud_authentication
      @permissions[:permissions][:AdministerCloudAuthentication] = true
      self
    end
  end

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

    # Change the role's permissions
    # @example
    #   client = Rublox::Client.new("COOKIE")
    #   permissions = Rublox::RolePermissions.new
    #     .manage_items
    #     .create_items
    #
    #   role = client
    #     .group_from_id(1)
    #     .member_by_id(1)
    #     .role
    #   role.change_permissions(permissions)
    # @param permissions [RolePermissions]
    # @return [nil]
    def change_permissions(permissions)
      @client.http_client.patch(
        URL.endpoint("groups", "v1/groups/#{@group.id}/roles/#{@id}/permissions"),
        json: permissions._permisions
      )

      nil
    end

    # Get the role's permissions
    # @example
    #   client = Rublox::Client.new("COOKIE")
    #
    #   role = client
    #     .group_from_id(1)
    #     .member_by_id(1)
    #     .role
    #   permissions = role.permissions
    # @return [RolePermissions]
    def permissions
      RolePermissions.from_data(
        @client.http_client.get(
          URL.endpoint("groups", "v1/groups/#{@group.id}/roles/#{@id}/permissions")
        )
      )
    end

    # Edit the role's information
    # @example
    #   role = client
    #     .group_from_id(1)
    #     .member_by_id(1)
    #     .role
    #
    #   role.edit(name: "cool epic name", rank: 255)
    #   role.edit(name: "some better name", description: "cool role")
    # @param name [String, nil]
    # @param description [String, nil]
    # @param rank [Integer, nil]
    # @return [nil]
    def edit(name: nil, description: nil, rank: nil)
      @client.http_client.patch(
        URL.endpoint("groups", "v1/groups/#{@group.id}/rolesets/#{@id}"),
        json: {
          name: name || @name,
          description: description || @description,
          rank: rank || @rank
        }
      )

      nil
    end
  end
end
