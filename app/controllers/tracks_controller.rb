class TracksController < ApplicationController
  before_action :load_track, only: [:show, :update, :destroy]
  
  def index
    if params[:q].present?
      @tracks = Track.search_by_dsl(params[:q], params[:artist_id], params[:album_id], params[:sort])
    else
      @tracks = Track.all
    end

    @tracks = @tracks.includes(:album, :artist).page(params[:page]).per(10)
      
    render json: TrackBlueprint.render(@tracks)
  end

  def show
    render json: TrackBlueprint.render(@track)
  end

  def create
    params["track"].merge!(
      album_name: Album.find_by(id: params.dig(:track, :album_id))&.title,
      artist_name: Artist.find_by(id: params.dig(:track, :artist_id))&.name
    )
    
    @track = Track.create!(track_params)
    render json: TrackBlueprint.render(@track), status: :created
  end

  def update
    @track.update!(track_params)
    render json: TrackBlueprint.render(@track)
  end

  def destroy
    @track.destroy
  end
  
  private
  def load_track
    @track = Track.find(params[:id])
  end
  
  def track_params
    params.require(:track).permit(:title, :artist_name, :album_name, :album_id, :artist_id)
  end
end
