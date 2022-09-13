class TracksController < ApplicationController
  before_action :load_track, only: [:show, :update, :destroy]
  
  def index 
    @tracks = Track.all
      .where("title LIKE :search or artist_name LIKE :search or album_name LIKE :search", search: "%#{params[:search]}%")      
      # .where("to_tsvector(title, artist_name, album_name) @@ to_tsquery(?)", params[:search])
      .order(params[:sort] ? "#{params[:sort]} desc" : "")
      .page(params[:page])
      .per(100)
      
    render json: TrackBlueprint.render(@tracks)
  end

  def show
    render json: TrackBlueprint.render(@track)
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      render json: TrackBlueprint.render(@track), status: :created
    else
      render json: @track.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @track.update(track_params)
      render json: TrackBlueprint.render(@track)
    else
      render json: @track.errors.full_messages, status: :unprocessable_entity
    end
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
