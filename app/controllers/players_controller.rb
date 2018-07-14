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

  def ready
    game.pregame!
    player = game.players.find(params[:player_id])
    player.ready = true
    player.save!

    players = game.players.to_a
    if players.all?(&:ready?)
      game.state = "playing"
      game.save!

      players.shuffle.each_with_index do |player, i|
        player.position = i + 1
        player.save!
      end
    end
  end

  def not_ready
    game.pregame!
    player = game.players.find(params[:player_id])
    player.ready = false
    player.save!
  end

  private

  def game
    @game ||= Game.where(identifier: params[:game_id]).first!
  end
end
