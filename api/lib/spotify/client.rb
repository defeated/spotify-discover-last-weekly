require 'oauth2/access_token'

module Spotify
  # main interface to spotify api
  class Client
    class << self
      attr_accessor :oauth
    end

    attr_reader :tokens

    def initialize(tokens = {})
      @tokens = tokens
      @connection = Connection.new self.class.oauth.site
    end

    def refresh
      @tokens = access_token.refresh!.to_hash.reject do |key|
        key == 'token_type'
      end
    end

    def playlists
      url = '/me/playlists'
      @connection.get url, headers
    end

    def tracks(playlist_id)
      url = '/users/spotifydiscover/playlists/' + playlist_id + '/tracks'
      @connection.get url, headers
    end

    private

    def access_token
      OAuth2::AccessToken.from_hash self.class.oauth, tokens
    end

    def headers
      { 'Authorization' => 'Bearer ' + tokens[:access_token] }
    end
  end
end
