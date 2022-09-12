class PlaylistTracksController < ApplicationController
  def create
    do_or_render_403 do
      @playlist_track = PlaylistTrack.create(playlist_track_params)
    end
  end


  def destroy
    do_or_render_403 do
      @playlist.playlist_tracks.find(params[:id]).destroy
    end
  end

  private
  def do_or_render_403 &block
    if check_user
      yield
    else
      render json: { error: "You don't have permission to do this." }, status: 403
    end
  end

  def check_user
    # 그룹인 경우 그룹에 속한 사용자만 생성 혹은 삭제할 수 있다.
    # 그룹이 아닌 경우는 그냥 생성 혹은 삭제할 수 있다.
    @playlist = Playlist.find(params.dig(:playlist_track, :playlist_id))
    @user = User.find(params.dig(:playlist_track, :user_id))
    @playlist.check_user(@user)
  end

  def playlist_track_params
    params.require(:playlist_track).permit(:playlist_id, :track_id, :user_id)
  end
end
