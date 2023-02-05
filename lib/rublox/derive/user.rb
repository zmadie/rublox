# frozen_string_literal: true

require "rublox/util/api_helper"
require "rublox/derive/model"

module Rublox
	module Derive
		module User
			include Model

			# @return [Integer] the amount of robux the current authenticated user has
			def currency
				APIHelper.get("https://economy.roblox.com/v1/users/#{@id}/currency")["robux"]
			end

			# @return [Boolean]
			def premium?
				APIHelper.get("https://premiumfeatures.roblox.com/v1/users/#{@id}/validate-membership")
			end

			# @return [Integer]
			def friend_count
				get_generic_count "friends"
			end

			# @return [Integer]
			def follower_count
				get_generic_count "followers"
			end

			# @return [Integer]
			def followings_count
				get_generic_count "followings"
			end

			private

			def get_generic_count(channel)
				APIHelper.get("https://friends.roblox.com/v1/users/#{@id}/#{channel}/count")["count"]
			end
		end
	end
end
