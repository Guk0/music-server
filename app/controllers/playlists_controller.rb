class PlaylistsController < ApplicationController
  before_action :load_owner
  before_action :load_playlist, only: [:show, :update, :destroy]

  def index
    playlists = @owner.playlists.where(list_type: Playlist.list_types.dig(params[:list_type])).page(params[:page]).per(10)
    render json: playlists.to_json
  end
  
  def show # tracks과 함께 보여줘야함.
    render json: @playlist.to_json
  end

  def create
    playlist = Playlist.create(playlist_params)
    render json: playlist.to_json
  end

  def update
    playlist = @playlist.update(playlist_params)
    render json: playlist.to_json
  end

  def destroy
    @playlist.destroy
    render status: 200
  end  

  private
  def load_owner
    # owner_type이 올바르지 않다면 key_error.
    # owner가 존재하지 않다면 ActiveRecord::RecordNotFound.
    # exception 발생시 json return 함수 필요함.
    @owner = Playlist::PERMITTED_OWNER.fetch(params[:owner_type]&.to_sym).find(params[:owner_id])
  end

  def load_playlist
    @playlist = @owner.playlists.find_by(id: params[:id])
  end
  
  def playlist_params
    params.require(:playlist).permit(:owner_type, :owner_id, :list_type, :title)
  end
end
