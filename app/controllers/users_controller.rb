class UsersController < ApplicationController
  def index
    users = User.all.page(params[:page]).per(10)
    render json: UserBlueprint.render(users)
  end

  def show
    user = User.find(params[:id])
    render json: UserBlueprint.render(user, view: :with_playlists)
  end
end
