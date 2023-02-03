# frozen_string_literal: true

require "rublox/derive/user"

module Rublox
	module Models
		class FullUser
			include Derive::User

			# @return [String]
			attr_reader :description
			# @return [Time]
			attr_reader :created
			# @return [Boolean]
			attr_reader :is_banned
			# @return [String?]
			attr_reader :external_app_display_name
			# @return [Boolean]
			attr_reader :has_verified_badge
			# @return [Integer]
			attr_reader :id
			# @return [String]
			attr_reader :name
			# @return [String]
			attr_reader :display_name

			# @!visibility private
			def initialize(data)
				@description = data["description"]
				@created = Time.iso8601(data["created"])
				@is_banned = data["isBanned"]
				@external_app_display_name = data["externalAppDisplayName"]
				@has_verified_badge = data["hasVerifiedBadge"]
				@id = data["id"]
				@name = data["name"]
				@display_name = data["displayName"]
			end
		end
	end
end
