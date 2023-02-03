# frozen_string_literal: true

require "rublox/models/group_shout"
require "rublox/util/api_helper"

module Rublox
	module Derive
		module Group
			# @return [Models::GroupShout] the new group shout
			def update_shout(message)
				Models::GroupShout.new(APIHelper.patch(
					"https://groups.roblox.com/v1/groups/#{@id}/status",
					json: { message: message }
				))
			end

			def accept_join_request(user_id)
				APIHelper.post("https://groups.roblox.com/v1/groups/#{@id}/join-requests/users/#{user_id}")
				nil
			end

			def decline_join_request(user_id)
				APIHelper.delete("https://groups.roblox.com/v1/groups/#{@id}/join-requests/users/#{user_id}")
				nil
			end

			def kick(user_id)
				APIHelper.delete("https://groups.roblox.com/v1/groups/#{@id}/users/#{user_id}")
				nil
			end
		end
	end
end
