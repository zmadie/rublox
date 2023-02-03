# frozen_string_literal: true

require "rublox/models/skinny_user"

module Rublox
	module Models
		class GroupShout
			# @return [String]
			attr_reader :body
			# @return [SkinnyUser]
			attr_reader :poster
			# @return [Time]
			attr_reader :created
			# @return [Time]
			attr_reader :updated

			# @!visibility private
			def initialize(data)
				@body = data["body"]
				@poster = SkinnyUser.new(data["poster"])
				@created = Time.iso8601(data["created"])
				@updated = Time.iso8601(data["updated"])
			end
		end
	end
end
