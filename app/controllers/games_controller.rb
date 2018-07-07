class GamesController < ApplicationController
  before_action :require_user

  def index
    @in_progress_games = current_user.games.in_progress
    @pending_games = Game.awaiting_players
  end

  def create
    game = Game.create
    game.players.create user: current_user, position: 1
    redirect_to game
  end

  def show
    @game = Game.where(identifier: params[:id]).first
  end
end
