class AlbumsController < ApplicationController
  before_action :load_album, only: [:show, :update, :destroy]
  
  def index 
    @albums = Album.page(params[:page]).per(100)
    render json: AlbumBlueprint.render(@albums)
  end

  def show
    render json: AlbumBlueprint.render(@album, view: :detail)
  end

  def create
    @album = Album.create!(album_params)
    render json: AlbumBlueprint.render(@album)
  end

  def update    
    @album.update!(album_params)
    render json: AlbumBlueprint.render(@album)
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
