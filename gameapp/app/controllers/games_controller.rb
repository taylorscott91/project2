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
  #  @game = Game.create!(game_params)

    redirect_to group_games_path(@group)
  end

  #show
  def show
    @game = Game.find(params[:id])
  end

  # edit
  def edit
    @game = Game.find(params[:id])
  end

  # update
  def update
    @game = Game.find(params[:id])
    @game.update(game_params)

    redirect_to games_path(@game)
  end

  # destroy
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path
  end

  private
  def game_params
    params.require(:game).permit(:name, :url, :group_id)
  end
end
