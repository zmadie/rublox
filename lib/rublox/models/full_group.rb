# frozen_string_literal: true

require "rublox/derive/group"
require "rublox/models/skinny_user"
require "rublox/models/group_shout"

module Rublox
	module Models
		class FullGroup
			include Derive::Group

			# @return [Integer]
			attr_reader :id
			# @return [String]
			attr_reader :name
			# @return [String]
			attr_reader :description
			# @return [SkinnyUser, nil]
			attr_reader :owner
			# @return [GroupShout, nil]
			attr_reader :shout
			# @return [Integer]
			attr_reader :member_count
			# @return [Boolean]
			attr_reader :is_builders_club_only
			# @return [Boolean]
			attr_reader :public_entry_allowed
			# @return [Boolean]
			attr_reader :is_locked
			# @return [Boolean]
			attr_reader :has_verified_badge

			# @!visibility private
			def initialize(data)
				owner_data = data["owner"]
				shout_data = data["shout"]
				@id = data["id"]
				@name = data["name"]
				@description = data["description"]
				@owner = SkinnyUser.new(owner_data) if owner_data
				@shout = GroupShout.new(shout_data) if shout_data
				@member_count = data["memberCount"]
				@is_builders_club_only = data["isBuildersClubOnly"]
				@public_entry_allowed = data["publicEntryAllowed"]
				@is_locked = !data["isLocked"].nil?
				@has_verified_badge = data["hasVerifiedBadge"]
			end

			# Updates the group shout and sets {#shout} to the new group shout
			# @return [nil]
			def update_shout!(message)
				@shout = update_shout(message)
			end
		end
	end
end
