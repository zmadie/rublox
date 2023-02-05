# frozen_string_literal: true

require "rublox/derive/model"
require "rublox/bases/base_user"

module Rublox
	module Models
		module PresenceType
			OFFLINE = :offline
			ONLINE = :online
			IN_GAME = :in_game
			IN_STUDIO = :in_studio

			PRESENCE_MAP = [
				OFFLINE,
				ONLINE,
				IN_GAME,
				IN_STUDIO
			].freeze
			private_constant :PRESENCE_MAP

			# @!visibility private
			def self.get(enum)
				PRESENCE_MAP[enum]
			end
		end

		class Presence
			include Derive::Model

			# @return [PresenceType]
			attr_reader :user_presence_type
			# @return [String]
			attr_reader :last_location

			# attr_reader :place_id
			# attr_reader :root_place_id
			# attr_reader :game_id
			# attr_reader :universe_id

			# @return [Bases::BaseUser]
			attr_reader :user
			# @return [Time]
			attr_reader :last_online

			# @!visibility private
			def initialize(data)
				@user_presence_type = PresenceType.get(data["userPresenceType"])
				@last_location = data["lastLocation"]
				# @place_id = data["placeId"]
				# @root_place_id = data["rootPlaceId"]
				# @game_id = data["gameId"]
				# @universe_id = data["universeId"]
				@user = Bases::BaseUser.new(data["userId"])
				@last_online = Time.iso8601(data["lastOnline"])

				@id = @user_id
			end
		end
	end
end
