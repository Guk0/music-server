class Track < ApplicationRecord
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :album_name, presence: true
  
  belongs_to :artist
  belongs_to :album

  has_many :playlist_tracks, dependent: :destroy
end
