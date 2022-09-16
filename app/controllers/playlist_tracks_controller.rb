class PlaylistTracksController < ApplicationController
  before_action :load_playlist
  before_action :load_user
  before_action :check_user

  def create
    @playlist_track = PlaylistTrack.create(playlist_track_params)
  end


  def destroy
    @playlist.playlist_tracks.find(params[:id]).destroy
  end

  private
  def load_playlist
    @playlist = Playlist.find(params.dig(:playlist_track, :playlist_id))
  end

  def load_user
    @user = User.find(params.dig(:playlist_track, :user_id))
  end
  
  def playlist_track_params
    params.require(:playlist_track).permit(:playlist_id, :track_id, :user_id)
  end

  def check_user
    unless @playlist.check_user(@user)
      raise ApplicationController::Forbidden
    end
  end
end
