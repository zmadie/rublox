# frozen_string_literal: true

module Rublox
  # Module for making URLs.
  module URL
    # The base URL to be used. If using a proxy, you can change the URL as long
    # as it follows Roblox's API structure:
    #   https://users.roblox.com/v1/users/1
    #   Bad:
    #   https://myproxy.test/get-user/1
    #   https://myproxy.test/users/1
    #   https://users.myproxy.test/users/1
    #   Good:
    #   https://users.myproxy.test/v1/users/1
    BASE_URL = "roblox.com"

    # Creates an endpoint URL from the the given ApiSite and path.
    # @param api_site [String] ApiSite
    # @param path [String]
    # @return [String] the endpoint
    def self.endpoint(api_site, path)
      "https://#{api_site}.#{BASE_URL}/#{path}"
    end
  end
end
