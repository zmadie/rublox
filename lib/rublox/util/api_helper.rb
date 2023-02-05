# frozen_string_literal: true

require "http"
require "json"

require "rublox/util/errors"

module Rublox
	module APIHelper
		@client = HTTP::Client.new

		# @!visibility private
		def self.roblosecurity=(roblosecurity)
			@client = @client.cookies(
				{
					".ROBLOSECURITY" => roblosecurity
				}
			)
		end

		def self.get(url, *args)
			request(:get, url, *args)
		end

		def self.post(url, *args)
			request(:post, url, *args)
		end

		def self.patch(url, *args)
			request(:patch, url, *args)
		end

		def self.delete(url, *args)
			request(:delete, url, *args)
		end

		def self.request(method, url, *args)
			response = @client.request(method, url, *args)
			case response.status
			when 200
				JSON.parse(response.body)
			when 403
				if JSON.parse(response.body).any? { |error| error.code.zero? }
					@client = @client.headers(
						{
							"x-csrf-token" => response.headers
						}
					)
				else
					raise Errors::UnhandledStatusCodeError.new(response, get_errors_from_response(response))
				end
			when 401
				raise Errors::InvalidROBLOSECURITYError
			else
				raise Errors::UnhandledStatusCodeError.new(response, get_errors_from_response(response))
			end
		end

		def self.get_errors_from_response(response)
			body = JSON.parse(response.body)
		rescue JSON::ParserError
			"\ncould not parse errors, raw body:\n#{response.body}\n"
		else
			body["errors"].reduce("") do |error_message, error|
				error_message + "\tCode: #{error['code']}\n\tMessage: #{error['message']}\n\n"
			end
		end

		private_class_method :request, :get_errors_from_response
	end
end
