class PlayersController < ApplicationController
  before_action :require_user

  def create
    game = Game.where(identifier: params[:game_id]).first
    player = game.players.build
    player.position = params[:position]
    player.user = current_user
    player.save!
    head :ok
  end
end
