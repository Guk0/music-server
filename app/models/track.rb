class Track < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  has_many :playlist_tracks, dependent: :destroy
end
