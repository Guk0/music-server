class UserGroupsController < ApplicationController
  before_action :load_group
  before_action :load_group_owner
  before_action -> { authenticate_user(@group, @owner) }
  before_action :load_user_group, only: [:destroy]  
  
  def create
    @group.users << User.find(params[:user_id])
  end
  
  def destroy
    @user_group.destroy
  end

  private
  def load_group
    @group = Group.find(params[:group_id])
  end

  def load_group_owner
    @owner = User.find(params[:owner_id])
  end

  def load_user_group
    @user_group = @group.user_groups.find(params[:id])
  end
end
