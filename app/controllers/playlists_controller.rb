class PlaylistsController < ApplicationController
  before_action :load_owner, only: [:create, :update, :destroy]
  before_action :load_playlist, only: [:update, :destroy]

  def index
    playlists = Playlist.my_album.page(params[:page]).per(10)
    render json: PlaylistBlueprint.render(playlists)
  end
  
  def show
    playlist = Playlist.my_album.find(params[:id])
    render json: PlaylistBlueprint.render(playlist, view: :detail)
  end

  def create
    playlist = @owner.playlists.my_album.create(playlist_params)
    render json: PlaylistBlueprint.render(playlist)
  end

  def update
    @playlist.update(playlist_params)
    render json: PlaylistBlueprint.render(@playlist)
  end

  def destroy
    @playlist.destroy
  end

  private
  def load_owner
    # owner_type이 올바르지 않다면 key_error.
    # owner가 존재하지 않다면 ActiveRecord::RecordNotFound.
    # exception 발생시 json return 함수 필요함.
    # 로그인을 추가할 시 owner에 대한 추가적인 검증이 필요함.
    @owner = Playlist::PERMITTED_OWNER.fetch(params[:owner_type]&.to_sym).find(params[:owner_id])
  end

  def load_playlist
    @playlist = @owner.playlists.my_album.find_by(id: params[:id])
  end
  
  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
