require 'omniauth/strategies/spotify'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,
           Rails.application.secrets.spotify_client_id,
           Rails.application.secrets.spotify_client_secret,
           scope: ['playlist-modify-public'],
           show_dialog: true
end
