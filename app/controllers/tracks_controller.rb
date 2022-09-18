class TracksController < ApplicationController
  before_action :load_track, only: [:show, :update, :destroy]
  
  def index
    result_tracks = Track.search_by_dsl(params)
    tracks = result_tracks.records.includes(:album, :artist)

    render json: { 
      total_count: result_tracks.total_count, 
      current_page: result_tracks.current_page, 
      data: TrackBlueprint.render_as_hash(tracks, view: :with_association) 
    }
  end

  def show
    render json: TrackBlueprint.render(@track, view: :with_association)
  end

  def create
    params["track"].merge!(
      album_name: Album.find_by(id: params.dig(:track, :album_id))&.title,
      artist_name: Artist.find_by(id: params.dig(:track, :artist_id))&.name
    )
    
    track = Track.create!(track_params)
    render json: TrackBlueprint.render(track, view: :with_association), status: :created
  end

  def update
    @track.update!(track_params)
    render json: TrackBlueprint.render(@track, view: :with_association)
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
