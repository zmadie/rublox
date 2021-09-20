# frozen_string_literal: true

require "rublox/util/url"
require "rublox/util/cache"

module Rublox
  # The order to sort pages in.
  module SortOrder
    # Sort the pages ina ascending order.
    ASCENDING = "Asc"
    # Sort the pages in descending order.
    DESCENDING = "Desc"
  end

  # The {Pages} class acts as an iterator over pages returned by the API.
  # @!visibility private
  # @todo Make more customizable, polish and battle-test
  # @note Only use if you have an use case that the library doesn't cover (and
  #   create an issue and perhaps we'll implement it!).
  class Pages
    # How many items are returned per page
    PAGE_DATA_LIMIT = 100

    # @!visibility private
    DEFAULT_REQUEST_PARAMETERS = {
      params: {
        sortOrder: SortOrder::DESCENDING,
        limit: PAGE_DATA_LIMIT
      }
    }.freeze

    # @param client [Client]
    # @param initial_data [Hash]
    # @param url [String]
    # @param request_params [Hash]
    def initialize(client, initial_data, url, request_params = {}, &data_handler)
      request_params[:params] = DEFAULT_REQUEST_PARAMETERS[:params].merge(
        request_params
      )

      @client = client
      @raw_data = initial_data
      @url = url
      @request_parameters = request_parameters
      @data_handler = data_handler

      @data = []
    end

    # Iterate over the pages
    def each
      raise unless block_given?
      # i = 0

      # until @raw_data
      #   if i == @data.length
      #     i = 0
      #     data = Cache.get(Cache::PAGE, @raw_data["nextPageCursor"])
      #     if data
      #       @data = data
      #     else
      #       @raw_data, @data = next_page
      #       break if @raw_data.empty?

      #       Cache.set(Cache::PAGE, @raw_data["nextPageCursor"], @data)
      #     end
      #   end

      #   yield @data[i]
      #   i += 1
      # end
    end

    private

    # @return [Array] tuple {raw data, processed data}
    def next_page
      @request_parameters[:params][:cursor] = @raw_data["nextPageCursor"]

      data = @client.http_client.get(@url, @request_parameters)

      [data["data"], @data_handler.call(data["data"])]
    end
  end
end
