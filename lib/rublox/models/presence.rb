# frozen_string_literal: true

require "time"

module Rublox
  # The state of the presence.
  #
  # Can be offline, online/on the website, playing a game, developing on studio.
  module PresenceType
    # The user is/was offline.
    OFFLINE = :Offline
    # The user is/was online (this also applies to the website).
    ONLINE = :Online
    # The user is/was playing a game.
    GAME = :"In game"
    # The user is/was developing on studio.
    STUDIO = :"In Studio"

    # @!visibility private
    PRESENCE_MAP = [
      OFFLINE,
      ONLINE,
      GAME,
      STUDIO
    ].freeze

    # Convert the Roblox PresenceType enum response to rublox's PresenceType
    # equivalent.
    # @!visibility private
    # @param enum [Integer]
    # @return [Symbol]
    def self.enum_to_presence_type(enum)
      PRESENCE_MAP[enum]
    end
  end

  # @note This class is handled internally by the public interface such as
  #   {Client#user_presence_from_id}. You should not be creating it yourself.
  # The {Presence} class corresponds to a response you can get via
  # https://presence.roblox.com/v1/presence/users. You can use it to get information
  # about the presence states of users.
  class Presence
    # @return [PresenceType] the current presence type
    attr_reader :presence_type

    # @return [PresenceType] the last presence type of the user
    attr_reader :last_presence_type

    # @note Unlike it sounds, this is not a numerical ID like of a user. It's a
    # randomly generated string with hexadecimal numbers containing the server's
    # job ID (which looks like "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"), it can be
    # also accessed in-game via the game.JobId property.
    # @return [String, nil] the job ID of the game last played by the user.
    attr_reader :game_job_id

    # @return [Time] the date at which the user was last online
    attr_reader :last_online_date

    def initialize(data, client)
      @presence_type = PresenceType.enum_to_presence_type(data["userPresenceType"])
      @last_location = data["lastLocation"]
      @place_id = data["placeId"]
      @root_place_id = data["rootPlaceId"]
      @game_job_id = data["gameId"]
      @universe_id = data["universeId"]
      @user_id = data["userId"]
      @last_online_date = Time.iso8601(data["lastOnline"])

      @client = client
    end

    # @todo add Place class
    # @return [Place, nil] the place last visited by the user, can be nil if the
    #   user has never played a game
    def place
      return unless @place_id
    end

    # @todo add Place class
    # @return [Place, nil] the root of the place last visited by the user, can
    #   be nil if the user has never played a game
    def root_place
      return unless @root_place_id
    end

    # @todo add Universe class
    # @return [Universe, nil] the universe of the place last visited by the user,
    #   can be nil if the user has never played a game
    def universe
      return unless @universe_id
    end

    # @return [FullUser] the user tied to the presence
    def user
      @client.user_from_id(@user_id)
    end
  end
end
