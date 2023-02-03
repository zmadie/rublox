# frozen_string_literal: true

require "rublox/derive/group"

module Rublox
	module Bases
		class BaseGroup
			include Derive::Group

			# @return [Integer]
			attr_reader :id

			# @!visibility private
			def initialize(id)
				@id = id
			end
		end
	end
end
