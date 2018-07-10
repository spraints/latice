class PlayersController < ApplicationController
  before_action :require_user

  def create
    game.pregame!
    game.not_full!
    player = game.players.build
    player.user = current_user
    player.save!
    head :ok
  end

  def destroy
    game.pregame!
    player = game.players.find(params[:id])
    player.destroy!
    head :ok
  end

  private

  def game
    @game ||= Game.where(identifier: params[:game_id]).first!
  end
end
