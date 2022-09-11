class ArtistsController < ApplicationController
  before_action :load_artist, only: [:show, :update, :destroy]
  
  def index 
    @artists = Artist.all
  end

  def show
  end

  def create
    @artist = Artist.create(artist_params)
  end

  def update
    @artist.update(artist_params)
  end

  def destroy
    @artist.destroy
  end
  
  private
  def load_artist
    @artist = Artist.find(params[:id])
  end
  
  def artist_params
    params.require(:artist).permit(:name)
  end
end
