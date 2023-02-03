# frozen_string_literal: true

require "rublox/derive/user"

module Rublox
	module Bases
		class BaseUser
			include Derive::User

			# @return [Integer]
			attr_reader :id

			# @!visibility private
			def initialize(id)
				@id = id
			end
		end
	end
end
