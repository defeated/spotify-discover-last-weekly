class BackupPlaylistJob < ActiveJob::Base
  queue_as :default

  def perform(playlist)
    tokens = playlist.user.auth_token.attributes.symbolize_keys
    spotify = Spotify::Client.new tokens
    tracks = spotify.tracks playlist.pid

    raise tracks.inspect
  end
end
