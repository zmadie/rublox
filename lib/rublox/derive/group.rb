# frozen_string_literal: true

require "rublox/models/group_shout"
require "rublox/models/group_role"
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

			# @return [nil]
			def accept_join_request(user_id)
				APIHelper.post("https://groups.roblox.com/v1/groups/#{@id}/join-requests/users/#{user_id}")
				nil
			end

			# @return [nil]
			def decline_join_request(user_id)
				APIHelper.delete("https://groups.roblox.com/v1/groups/#{@id}/join-requests/users/#{user_id}")
				nil
			end

			# @return [nil]
			def kick(user_id)
				APIHelper.delete("https://groups.roblox.com/v1/groups/#{@id}/users/#{user_id}")
				nil
			end

			# @return [Array<Models::GroupRole>]
			def roles
				APIHelper.get("https://groups.roblox.com/v1/groups/#{@id}/roles")["roles"].map { |data| GroupRole.new(data) }
			end

			# Updates the role of the member with the specified user ID to the role with the specified role ID
			# @return [nil]
			def update_user_role(user_id, role_id)
				APIHelper.patch(
					"https://groups.roblox.com/v1/groups/#{@id}/users/#{user_id}",
					json: { roleId: role_id }
				)
				nil
			end
		end
	end
end
