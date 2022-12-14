class PlaylistsController < ApplicationController
  before_action :load_owner, only: [:my_playlist, :create, :update, :destroy]
  before_action :load_playlist, only: [:update, :destroy]

  def index
    # TODO my_album 타입의 playlist filtering
    playlists = Playlist.includes(:owner, owner: :owner).my_album.page(params[:page]).per(10)
    render json: PlaylistBlueprint.render(playlists, view: :with_owner)
  end
  
  def show
    playlist = Playlist.find(params[:id])
    authorize playlist if playlist.default?
    render json: PlaylistBlueprint.render(playlist)
  end

  def my_playlist
    authorize @owner, policy_class: PlaylistPolicy
    playlists = @owner.playlists.page(params[:page]).per(10)
    render json: PlaylistBlueprint.render(playlists, view: :with_owner)
  end

  def create
    authorize @owner, :my_playlist?, policy_class: PlaylistPolicy
    playlist = @owner.playlists.my_album.create(playlist_params)
    render json: PlaylistBlueprint.render(playlist, view: :with_owner)
  end

  def update
    authorize @playlist
    @playlist.update(playlist_params)
    render json: PlaylistBlueprint.render(@playlist, view: :with_owner)
  end

  def destroy
    authorize @playlist
    @playlist.destroy
    render json: { message: "successfully destroy object" }, status: 204
  end

  private
  def load_owner
    # owner_type이 올바르지 않다면 key_error.
    # owner가 존재하지 않다면 ActiveRecord::RecordNotFound.
    # exception 발생시 json return 함수 필요함.
    @owner = Playlist::PERMITTED_OWNER.fetch(params[:owner_type]&.to_sym).find(params[:owner_id])
  end

  def load_playlist
    @playlist = @owner.playlists.my_album.find_by(id: params[:id])
  end
  
  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
