class PlayersController < ApplicationController
  before_action :require_user

  def create
    player = game.players.build
    player.user = current_user
    player.save!
    head :ok
  end

  def destroy
    player = game.players.find(params[:id])
    player.destroy!
    head :ok
  end

  private

  def game
    @game ||= Game.where(identifier: params[:game_id]).first!
  end
end
