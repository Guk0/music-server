class PlaylistsController < ApplicationController
  before_action :load_owner, only: [:my_playlist, :create, :update, :destroy]
  before_action :load_user, only: [:my_playlist, :create, :update, :destroy]
  # TODO my_playlist와 create에 @owner에 대한 검증이 필요함. @owner == user 인지.
  # before_action -> { authenticate_user(@owner, @user) }, only: [:my_playlist, :create]
  before_action :load_playlist, only: [:update, :destroy]
  before_action -> { authenticate_user(@playlist, @user) }, only: [:update, :destroy]

  def index
    playlists = Playlist.my_album.page(params[:page]).per(10)
    render json: PlaylistBlueprint.render(playlists, view: :with_owner)
  end
  
  def show # tracks과 함께 보여줘야함.
    playlist = Playlist.my_album.find(params[:id])
    render json: PlaylistBlueprint.render(playlist, view: :detail)
  end

  def my_playlist
    playlists = @owner.playlists.page(params[:page]).per(10)
    render json: PlaylistBlueprint.render(playlists, view: :with_owner)
  end

  def create
    # owner can create only my_album type in this action.
    playlist = @owner.playlists.my_album.create(playlist_params)
    render json: PlaylistBlueprint.render(playlist, view: :with_owner)
  end

  def update
    @playlist.update(playlist_params)
    render json: PlaylistBlueprint.render(@playlist, view: :with_owner)
  end

  def destroy
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

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_playlist
    @playlist = @owner.playlists.my_album.find_by(id: params[:id])
  end
  
  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
