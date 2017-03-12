class GamesController < ApplicationController
  # index
  # def index
  #   @group = Group.find(params[:id])
  #   @games = Game.all
  # end

  # new
  def new
    @group = Group.find(params[:group_id])
    @game = @group.games.new
  end

  # create
  def create
    @group = Group.find(params[:group_id])
    @group.games.create(game_params)
    # You are already assigning a group_id to the new game by using @group.games.create

    redirect_to group_path(@group)
  end

  #show
  def show
    @group = Group.find(params[:group_id])
    @game = Game.find(params[:id])
  end

  # edit
  def edit
    @group = Group.find(params[:group_id])
    @game = Game.find(params[:id])
  end

  # update
  def update
    @group = Group.find(params[:group_id])
    @game = Game.find(params[:id])
    @game.update(game_params)

    redirect_to group_game_path(@group,@game)
  end

  # destroy
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path
  end

  private
  def game_params
    params.require(:game).permit(:name)
    # This only filters out what can be submitted via form data. You only need to
    # allow in :name
  end
end
