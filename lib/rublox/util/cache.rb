# frozen_string_literal: true

module Rublox
  # @note Only use if you have an use case that the library doesn't cover (and
  #   create an issue and perhaps we'll implement it!).
  module Cache
    # The key for the user cache.
    USER = :users
    # The key for the group cache.
    GROUP = :groups
    # The key for the page cache.
    PAGE = :pages

    # @!visiblity private
    @cache = {
      users: {},
      groups: {},
      pages: {}
    }

    # Try to get an object from cache.
    # @param type [Symbol] {USER}, {GROUP} or {PAGE}
    # @param id [Integer] the ID of the object
    # @return [FullUser, FullGroup, Pages, nil]
    def self.get(type, id)
      @cache[type][id]
    end

    # Set an object in the cache, under the type's key.
    # @param type [Symbol] {USER}, {GROUP} or {PAGE}
    # @param id [Integer] the ID of the object
    # @param object [FullUser, FullGroup, Pages] the object to be added to the
    #   cache
    # @return [nil]
    def self.set(type, id, object)
      @cache[type][id] = object
    end
  end
end
