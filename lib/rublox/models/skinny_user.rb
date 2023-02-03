# frozen_string_literal: true

require "rublox/derive/user"

module Rublox
	module Models
		class SkinnyUser
			include Derive::User

			# @return [Integer]
			attr_reader :id
			# @return [String]
			attr_reader :name
			# @return [String]
			attr_reader :display_name
			# @return [Boolean]
			attr_reader :has_verified_badge

			# @!visibility private
			def initialize(data)
				@id = data["id"] || data["userId"]
				@name = data["name"] || data["username"]
				@display_name = data["displayName"]
				@has_verified_badge = data["hasVerifiedBadge"]
			end
		end
	end
end
