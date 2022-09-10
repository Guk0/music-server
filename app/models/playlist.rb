class Playlist < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :playlist_tracks, dependent: :destroy
end
