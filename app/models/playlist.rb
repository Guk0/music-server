class Playlist < ApplicationRecord
  PERMITTED_OWNER = {"User": User, "Group": Group}

  belongs_to :owner, polymorphic: true

  has_many :playlist_tracks, dependent: :destroy

  enum list_type: { default: 0, my_album: 1 }
end
