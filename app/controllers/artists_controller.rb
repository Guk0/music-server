class ArtistsController < ApplicationController
  before_action :load_artist, only: [:show, :update, :destroy]
  
  def index 
    @artists = Artist.page(params[:page]).per(100)
    render json: ArtistBlueprint.render(@artists)
  end

  def show
    render json: ArtistBlueprint.render(@artist)
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      render json: ArtistBlueprint.render(@artist), status: :created
    else
      render json: @artist.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @artist.update(artist_params)
      render json: ArtistBlueprint.render(@artist)
    else
      render json: @artist.errors.full_messages, status: :unprocessable_entity
    end
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
