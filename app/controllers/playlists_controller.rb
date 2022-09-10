class PlaylistsController < ApplicationController
  before_action :load_owner

  def index
    playlists = @owner.playlists.where(list_type: Playlist.list_types.dig(params[:list_type])).page(params[:page]).per(10)
    render json: playlists.to_json
  end
  
  def show # tracks과 함께 보여줘야함.
    playlist = @owner.playlists.find_by(id: params[:id])
    render json: playlist.to_json
  end

  def create
    @owner.playlists.create!(playlist_params)
    redner json: playlist.to_json
  end

  private
  def load_owner
    # owner_type이 Playlist::PERMITTED_OWNER의 key 값에 포함되지 않는다면 key_error를 발생하도록 함.
    @owner = Playlist::PERMITTED_OWNER.fetch(params[:owner_type]&.to_sym).find_by(id: params[:owner_id])    
  end

  def playlist_params
    params.require(:playlist).permit(:owner_type, :owner_id, :list_type, :title)
  end
end
