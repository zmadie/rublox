# frozen_string_literal: true

require "http"
require "json"

require "rublox/util/errors"

module Rublox
  # @note Only use if you have an use case that the library doesn't cover (and
  #   create an issue and perhaps we'll implement it!).
  # The {HTTPClient} is a wrapper around the http library, designed specifically
  # for the Roblox API. It automatically handles the X-CSRF-TOKEN and the
  # .ROBLOSECURITY cookie.
  class HTTPClient
    # @param roblosecurity [String]
    def initialize(roblosecurity = "")
      @client = HTTP.cookies(
        {
          ".ROBLOSECURITY": roblosecurity
        }
      )
    end

    # Send a GET request to the specified URL.
    # @param url [String]
    # @return [Hash]
    def get(url, *args)
      request(:get, url, *args)
    end

    # Send a POST request to the specified URL.
    # @param url [String]
    # @return [Hash]
    def post(url, *args)
      request(:post, url, *args)
    end

    # Send a PATCH request to the specified URL.
    # @param url [String]
    # @return [Hash]
    def patch(url, *args)
      request(:patch, url, *args)
    end

    # Send a DELETE request to the specified URL.
    # @param url [String]
    # @return [Hash]
    def delete(url, *args)
      request(:delete, url, *args)
    end

    private

    # @param verb [Symbol]
    # @param url [String]
    # @return [Hash]
    def request(verb, url, *args)
      response = @client.request(verb, url, *args)
      return JSON.parse(response.body) if response.status == 200

      handle_status_code(response, verb, url, *args)
    end

    # @param response [HTTP::Response]
    def handle_status_code(response, verb, url, *args)
      case response.status
      # token validation failed
      when 403
        @client = @client.headers(
          {
            "x-csrf-token": response.headers["x-csrf-token"]
          }
        )
        # retry the request
        request(verb, url, *args)
      # invalid .ROBLOSECURITY cookie
      when 401
        raise Errors::InvalidROBLOSECURITYError
      else
        raise Errors::UnhandledStatusCodeError.new(response.status, get_errors_from_response(response))
      end
    end

    # @param response [HTTP::Response]
    def get_errors_from_response(response)
      body = JSON.parse(response.body)
    rescue JSON::ParserError
      "\ncould not parse errors, raw body:\n#{response.body}\n"
    else
      body["errors"].reduce("") do |error_message, error|
        error_message + "\tCode: #{error['code']}\n\tMessage: #{error['message']}\n\n"
      end
    end
  end
end
