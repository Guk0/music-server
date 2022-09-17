class TracksController < ApplicationController
  before_action :load_track, only: [:show, :update, :destroy]
  
  def index
    # Track.__elasticsearch__.create_index!
    # Track.__elasticsearch__.import batch_size: 10000

    if params[:search].present?
      @tracks = Track.__elasticsearch__.search(params[:search]).records.records
    else
      @tracks = Track.all
    end

    @tracks = @tracks.includes(:album, :artist).page(params[:page]).per(10)
    # @tracks = Track.includes(:artist, :album)
    #   .where("title LIKE :search or artist_name LIKE :search or album_name LIKE :search", search: "%#{params[:search]}%")      
    #   # .where("to_tsvector(title, artist_name, album_name) @@ to_tsquery(?)", params[:search])
    #   .order(params[:sort] ? "#{params[:sort]} desc" : "")
    #   .page(params[:page])
    #   .per(100)
      
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
