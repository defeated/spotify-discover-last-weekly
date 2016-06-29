class Playlist < ActiveRecord::Base
  belongs_to :user

  validates :pid, presence: true
end
