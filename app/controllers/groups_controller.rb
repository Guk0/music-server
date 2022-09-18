class GroupsController < ApplicationController
  before_action :load_user, only: [:create, :update, :destroy]
  before_action :load_group, only: [:update, :destroy]
  before_action -> { authenticate_user(@group, @user) }, only: [:update, :destroy]

  def index
    groups = Group.all.page(params[:page]).per(10)
  end

  def show
    group = Group.find(params[:id])
  end
 
  def create
    @group = @user.owned_groups.create(group_params)
    @group.users << @user
  end
  
  def update
    @group.update(group_params)
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
