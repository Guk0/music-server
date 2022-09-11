class UserGroupsController < ApplicationController
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

  def load_user_group
    @user_group = UserGroup.find(params[:id])
  end
end
