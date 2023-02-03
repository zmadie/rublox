# frozen_string_literal: true

require "rublox/util/api_helper"
require "rublox/util/errors"
require "rublox/models/full_user"
require "rublox/models/skinny_user"
require "rublox/models/presence"
require "rublox/bases/base_user"
require "rublox/bases/base_group"

# rublox is a Roblox web API wrapper written in Ruby. It aims to provide an
# object oriented interface to get and modify data from Roblox's web API.
# Docs: https://rubydoc.info/gems/rublox
module Rublox
	# Sets the .ROBLOSECURITY cookie to send authenticated requests
	def self.roblosecurity=(roblosecurity)
		APIHelper.roblosecurity = roblosecurity
	end

	# Returns the current authenticated user
	def self.authenticated_user
		Models::SkinnyUser.new(APIHelper.get("https://users.roblox.com/v1/users/authenticated"))
	end

	# Returns a BaseUser
	def self.base_user(id)
		Bases::BaseUser.new(id)
	end

	# Returns a user
	def self.user_from_id(id)
		Models::FullUser.new(APIHelper.get("https://users.roblox.com/v1/users/#{id}"))
	rescue Errors::UnhandledStatusCodeError => e
		raise Errors::UserNotFoundError, cause: nil if e.response.status == 404

		raise
	end

	def self.users_from_ids(ids, exclude_banned_users: false)
		APIHelper.post(
			"https://users.roblox.com/v1/users",
			json: {
				userIds: ids,
				excludeBannedUsers: exclude_banned_users
			}
		)["data"].map { |data| Models::SkinnyUser.new(data) }
	end

	def self.users_from_usernames(usernames, exclude_banned_users: false)
		APIHelper.post(
			"https://users.roblox.com/v1/usernames/users",
			json: {
				usernames: usernames,
				excludeBannedUsers: exclude_banned_users
			}
		)["data"].map { |data| Models::SkinnyUser.new(data) }
	end

	def self.user_from_username(username, exclude_banned_users: false)
		users_from_usernames([username], exclude_banned_users: exclude_banned_users)[0] or raise Errors::UserNotFoundError
	end

	def self.base_group(id)
		Bases::BaseGroup.new(id)
	end

	def self.group_from_id(id)
		APIHelper.get("https://groups.roblox.com/v1/groups/#{id}")
	rescue Errors::UnhandledStatusCodeError => e
		raise Errors::GroupNotFoundError, cause: nil if e.response.status == 400

		raise
	end

	def self.user_presences_from_ids(ids)
		APIHelper.post(
			"https://presence.roblox.com/v1/presence/users",
			json: { userIds: ids }
		)["userPresences"].map { |data| Models::Presence.new(data) }
	rescue Errors::UnhandledStatusCodeError => e
		raise Errors::PresenceRequestError, cause: nil if e.response.status == 400

		raise
	end

	def self.user_presence_from_id(id)
		user_presences_from_ids([id])[0]
	end
end
