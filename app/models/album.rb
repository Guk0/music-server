class Album < ApplicationRecord
  validates :title, presence: true

  belongs_to :artist

  has_many :tracks

  after_update :update_album_name_of_tracks

  private
  def update_album_name_of_tracks
    tracks.update_all(album_name: title) if title_previously_was != title
  end
end
