require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Spotify < OmniAuth::Strategies::OAuth2
      option :name, 'spotify'
      option :authorize_options, %w[ scope show_dialog ]
      option :client_options,
             site: 'https://api.spotify.com/v1',
             authorize_url: 'https://accounts.spotify.com/authorize',
             token_url: 'https://accounts.spotify.com/api/token'

      uid do
        raw_info['id']
      end

      info do
        {
          name: raw_info['display_name'],
          email: raw_info['email'],
          image: raw_info['images'][0]['url']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end

    end
  end
end
