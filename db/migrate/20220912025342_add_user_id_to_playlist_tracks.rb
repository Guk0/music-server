class AddUserIdToPlaylistTracks < ActiveRecord::Migration[6.1]
  def change
    add_reference :playlist_tracks, :user, null: false, foreign_key: true
  end
end
