require 'spotify/client'
require 'spotify/connection'
require 'omniauth/strategies/spotify'

client_id = Rails.application.secrets.spotify_client_id
client_secret = Rails.application.secrets.spotify_client_secret
strategy = OmniAuth::Strategies::Spotify.new nil, client_id, client_secret

Spotify::Client.oauth = strategy.client
