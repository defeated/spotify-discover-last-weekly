require 'uri'
require 'json'
require 'net/http'

module Spotify
  # simple wrapper over net http lib
  class Connection
    def initialize(endpoint)
      @uri = URI.parse endpoint
    end

    def get(path, headers = {})
      request = Net::HTTP::Get.new uri.path + path, headers
      send request
    end

    private

    attr_reader :uri

    def send(request)
      opts = { use_ssl: ssl? }
      response = Net::HTTP.start uri.hostname, uri.port, opts do |http|
        http.request request
      end
      JSON.parse response.body
    end

    def ssl?
      uri.scheme == 'https'
    end
  end
end
