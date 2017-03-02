class GroupsController < ApplicationController
  # index
  def index
    @groups = Group.all
  end

  # new
  def new
    @group = Group.new
  end

  # create
  def create
    @group = Group.create!(group_params)

    redirect_to group_path(@group)
  end

  #show
  def show
    @group = Group.find(params[:id])
  end

  # edit
  def edit
    @group = Group.find(params[:id])
  end


  # update
  def update
    @group = Group.find(params[:id])
    @group.update(group_params)

    redirect_to group_path(@group)
  end

  # destroy
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
