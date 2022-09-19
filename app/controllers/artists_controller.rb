class ArtistsController < ApplicationController
  before_action :load_artist, only: [:show, :update, :destroy]
  
  def index 
    @artists = Artist.page(params[:page]).per(10)
    render json: ArtistBlueprint.render(@artists)
  end

  def show
    render json: ArtistBlueprint.render(@artist)
  end

  def create
    @artist = Artist.create!(artist_params)
    render json: ArtistBlueprint.render(@artist), status: :created
  end

  def update
    @artist.update(artist_params)
    render json: ArtistBlueprint.render(@artist)
  end

  def destroy
    @artist.destroy
    render json: { message: "successfully destroy object" }, status: 204
  end
  
  private
  def load_artist
    @artist = Artist.find(params[:id])
  end
  
  def artist_params
    params.require(:artist).permit(:name)
  end
end
