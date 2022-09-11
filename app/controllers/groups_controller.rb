class GroupsController < ApplicationController
  before_action :load_group, only: [:show, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
  end
 
  def create
    @group = Group.create(group_params)
    @group.users << User.find(params[:user_id])
  end
  
  def update
    @group.update(group_params)
  end
  
  def destroy
    @group.destroy
  end

  private
  def load_group
    @group = Group.find(params[:id])
  end
  
  def group_params
    params.require(:group).permit(:name)
  end
end
