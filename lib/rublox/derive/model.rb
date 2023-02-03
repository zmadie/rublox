# frozen_string_literal: true

module Rublox
	module Derive
		module Model
			# @return [String]
			def to_s
				"#<#{self.class} of ID #{@id}>"
			end

			# @return [Boolean]
			def ==(other)
				@id == other.id
			end
		end
	end
end
