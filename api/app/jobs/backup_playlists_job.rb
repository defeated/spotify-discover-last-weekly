class BackupPlaylistsJob < ActiveJob::Base
  queue_as :default

  def perform
    Playlist.find_each do |playlist|
      BackupPlaylistJob.perform_later playlist
    end
  end
end
