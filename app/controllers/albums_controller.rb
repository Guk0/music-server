class AlbumsController < ApplicationController
  before_action :load_album, only: [:show, :update, :destroy]
  
  def index 
    @albums = Album.page(params[:page]).per(100)
    render json: AlbumBlueprint.render(@albums, view: :detail)
  end

  def show
    render json: AlbumBlueprint.render(@album, view: :detail)
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      render json: AlbumBlueprint.render(@album), status: :created
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update    
    if @album.update(album_params)
      render json: AlbumBlueprint.render(@album)
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
  end
  
  private
  def load_album
    @album = Album.find(params[:id])
  end
  
  def album_params
    params.require(:album).permit(:title, :artist_id)
  end
end
