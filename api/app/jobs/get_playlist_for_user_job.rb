class GetPlaylistForUserJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    spotify = Spotify::Client.new user.auth_token.attributes.symbolize_keys
    weekly_playlist = spotify.playlists['items'].find do |playlist|
      playlist.dig('owner', 'id') == 'spotifydiscover'
    end

    playlist = user.playlist || user.build_playlist
    playlist.update! pid: weekly_playlist['id']
  end
end
