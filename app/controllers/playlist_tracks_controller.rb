class PlaylistTracksController < ApplicationController
  before_action :load_playlist

  def index
    authorize @playlist if @playlist.default?
    playlist_tracks = @playlist.playlist_tracks.includes(:track).page(params[:page]).per(10)
    render json: PlaylistTrackBlueprint.render(playlist_tracks)
  end

  def create
    authorize @playlist
    @playlist_track = PlaylistTrack.create(playlist_track_params)
    render status: :created
  end

  def destroy
    authorize @playlist
    @playlist.playlist_tracks.find(params[:id]).destroy!
    render json: { message: "successfully destroy object" }, status: 204
  end

  private
  def load_playlist
    @playlist = Playlist.find(params[:playlist_id] || params.dig(:playlist_track, :playlist_id))
  end
  
  def playlist_track_params
    params.require(:playlist_track).permit(:playlist_id, :track_id, :user_id)
  end
end
