class UserGroupsController < ApplicationController
  before_action :load_group, only: [:create]  
  before_action :load_user_group, only: [:destroy]  
  
  def create
    authorize @group
    @group.users << User.find(params[:user_id])
    render status: :created
  end
  
  def destroy
    authorize @user_group.group
    @user_group.destroy
    render status: 204
  end

  private
  def load_group
    @group = Group.find(params[:group_id])
  end

  def load_user_group
    @user_group = UserGroup.find(params[:id])
  end
end
