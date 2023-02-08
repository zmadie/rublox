# frozen_string_literal: true

module Rublox
	module Models
		class GroupRole
			# @return [Integer]
			attr_reader :id
			# @return [String]
			attr_reader :name
			# @return [String, nil]
			attr_reader :description
			# @return [Integer]
			attr_reader :rank
			# @return [Integer, nil]
			attr_reader :member_count
		end
	end
end
