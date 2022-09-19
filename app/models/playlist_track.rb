class PlaylistTrack < ApplicationRecord
  belongs_to :playlist
  belongs_to :track
  belongs_to :user

  after_save :limit_playlist_tracks

  private
  def limit_playlist_tracks
    # 생성할때마다 playlist의 counter_cache 칼럼 update 하기 vs 생성시 마다 count 쿼리로 확인하기.
    playlist_tracks = playlist.playlist_tracks.order(created_at: :desc)
    if playlist_tracks.size > 100
      playlist_tracks.last.destroy
    end
  end
end
