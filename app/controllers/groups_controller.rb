class GroupsController < ApplicationController
  before_action :load_user, only: [:create, :update, :destroy]
  before_action :load_group, only: [:update, :destroy]

  def index
    groups = Group.all.page(params[:page]).per(10)
  end

  def show
    group = Group.find(params[:id])
  end
 
  def create
    @group = @user.groups.create(group_params)
  end
  
  def update
    @group.update(group_params)
  end
  
  def destroy
    @group.destroy
  end

  private
  def load_user
    # current_user 역할. 일단은 user_id에 해당하는 객체의 group만 볼 수 있도록 작업.
    @user = User.find(params[:user_id])
  end

  def load_group
    @group = @user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
