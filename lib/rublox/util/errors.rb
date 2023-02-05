# frozen_string_literal: true

module Rublox
	module Errors
		# This error is raised when a user couldn't be found
		class UserNotFoundError < StandardError
		end

		# This error is raised when a group couldn't be found
		class GroupNotFoundError < StandardError
		end

		# This error is raised when one of the provided user IDs are invalid, or if a user ID is repeated
		class PresenceRequestError < StandardError
			# @!visibility private
			def initialize
				super("An invalid or repeated user ID was provided")
			end
		end

		# This error is raised when an error returned by the Roblox API should be dealt by the user
		class UnhandledStatusCodeError < StandardError
			# @return [HTTP::Response] the response object
			attr_reader :response
			# @return [String] a formatted string of errors returned by the Roblox API
			attr_reader :errors

			# @!visibility private
			def initialize(response, errors)
				super("Unhandled status code #{response.status}.\nRoblox errors:\n#{errors}")
				@response = response
				@errors = errors
			end
		end

		# This error is raised when a method that requires authentication is called without a valid .ROBLOSECURITY cookie set
		class InvalidROBLOSECURITYError < StandardError
			# @!visibility private
			def initialize
				super("A valid .ROBLOSECURITY cookie needs to be passed to Rublox for this action.")
			end
		end
	end
end
