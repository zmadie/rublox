# frozen_string_literal: true

module Rublox
  # This module contains errors that can be raised by rublox methods.
  module Errors
    # Exception raised when a user cannot be found.
    class UserNotFoundError < StandardError
      # @return [Integer, "(no ID information provided)"] the given user's ID
      attr_reader :user_id

      # @return [String, "(no username information provided)"] the given user's
      #   username
      attr_reader :user_username

      # @param user_id [Integer]
      # @param username [String, nil]
      def initialize(
        user_id = "(no ID information provided)",
        username = "(no username information provided)"
      )
        @user_id = user_id
        @user_username = username
        super("The user of ID #{user_id} and username #{username} could not be found.")
      end
    end

    # Exception raised when a group cannot be found.
    class GroupNotFoundError < StandardError
      # @return [Integer] the given group's ID
      attr_reader :group_id

      # @param group_id [Integer]
      def initialize(group_id)
        @group_id = group_id
        super("The group of ID #{group_id} could not be found.")
      end
    end

    # Exception raised when a user's presence cannot be found.
    class PresenceNotFoundError < StandardError
      # @return [Integer] the presence user's ID
      attr_reader :user_id

      def initialize(user_id)
        @user_id = user_id
        super("The presence of the user with ID #{user_id} could not be found.")
      end
    end

    # Exception raised when a user is not part of a group.
    class MemberNotFoundError < StandardError
      # @return [Integer] the given user's ID
      attr_reader :user_id

      # @return [Integer] the given group's ID
      attr_reader :group_id

      # @param id [Integer]
      # @param group_id [Integer]
      def initialize(id, group_id)
        @user_id = id
        @group_id = group_id
        super("The user of ID #{id} is not part of this group of ID #{group_id}")
      end
    end

    # Exception raised when a role doesn't exist.
    class RoleNotFoundError < StandardError
      # @return [Integer] the given role's ID
      attr_reader :role_id

      # @return [Integer] the given group's ID
      attr_reader :group_id

      # @param role_id [Integer]
      # @param group_id [Integer]
      def initialize(role_id, group_id)
        @role_id = role_id
        @group_id = group_id
        super("The role of ID #{role_id} does not exist in group of ID #{group_id}.")
      end
    end

    # Exception raised when an unhandled status code is returned.
    class UnhandledStatusCodeError < StandardError
      # @return [HTTP::Response::Status] the unhandled status code
      attr_reader :status_code

      # @return [String] a string containing all the errors returned by the API
      #   neatly formatted
      attr_reader :errors

      # @param status_code [Integer]
      # @param errors [String, nil]
      def initialize(status_code, errors = "")
        super("Unhandled status code #{status_code}.\nRoblox errors:\n#{errors}")
        @status_code = status_code
        @errors = errors
      end
    end

    # Exception raised when an invalid .ROBLOSECURITY cookie is used.
    class InvalidROBLOSECURITYError < StandardError
      def initialize
        super("A valid .ROBLOSECURITY cookie needs to be passed to Rublox's constructor for this action.")
      end
    end
  end
end
