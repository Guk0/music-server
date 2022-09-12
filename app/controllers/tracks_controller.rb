class TracksController < ApplicationController
  before_action :load_track, only: [:show, :update, :destroy]
  
  def index 
    @tracks = Track.all
    # .where("title LIKE :search or artist_name LIKE :search or album_name LIKE :search", search: "%#{params[:search]}%")
    # .order("#{params[:sort]} desc")
    # .page(params[:page])
    # .per(100)
  end

  def show
  end

  def create
    @track = Track.create(track_params)
  end

  def update
    @track.update(track_params)
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
