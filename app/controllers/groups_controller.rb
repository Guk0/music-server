class GroupsController < ApplicationController
  before_action :load_group, only: [:update, :destroy]  

  def index
    groups = Group.all.page(params[:page]).per(10)
    render json: GroupBlueprint.render(groups)
  end

  def show
    group = Group.find(params[:id])
    render json: GroupBlueprint.render(group, view: :with_playlists)
  end
 
  def create
    @group = current_user.owned_groups.create!(group_params)
    @group.users << current_user
    render json: GroupBlueprint.render(@group)
  end
  
  def update
    authorize @group
    @group.update(group_params)
    render json: GroupBlueprint.render(@group)
  end
  
  def destroy
    authorize @group
    @group.destroy
    render json: { message: "successfully destroy object" }, status: 204
  end

  private
  def load_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
