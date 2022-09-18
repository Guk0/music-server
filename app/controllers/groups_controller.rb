class GroupsController < ApplicationController
  before_action :load_user, only: [:create, :update, :destroy]
  before_action :load_group, only: [:update, :destroy]
  before_action -> { authenticate_user(@group, @user) }, only: [:update, :destroy]

  def index
    groups = Group.all.page(params[:page]).per(10)
    render json: GroupBlueprint.render(groups)
  end

  def show
    group = Group.find(params[:id])
    render json: GroupBlueprint.render(group, view: :with_playlists)
  end
 
  def create
    @group = @user.owned_groups.create(group_params)
    @group.users << @user
    render json: GroupBlueprint.render(@group)
  end
  
  def update
    @group.update(group_params)
    render json: GroupBlueprint.render(@group)
  end
  
  def destroy
    @group.destroy
  end

  private
  def load_user
    @user = User.find(params[:user_id])
  end

  def load_group
    @group = @user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
