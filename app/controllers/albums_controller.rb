class AlbumsController < ApplicationController
  before_action :load_album, only: [:show, :update, :destroy]
  
  def index 
    @albums = Album.all
  end

  def show
  end

  def create
    @album = Album.create(album_params)
  end

  def update
    @album.update(album_params)
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
