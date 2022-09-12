class Artist < ApplicationRecord
  validates :name, presence: true

  has_many :albums
  has_many :tracks  

  after_save :update_artist_name_of_tracks

  private
  def update_artist_name_of_tracks
    tracks.update_all(artist_name: name) if name_previously_was != name
  end
end
