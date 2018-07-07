# A thing we can provide as JSON to the UI.
class GameState
  def initialize(game:, current_user:)
    @game = game
    @current_user = current_user
  end

  def to_json(*x)
    {
      state: game.state,
      current_user: current_user.handle,
      players: players.map { |player|
        {
          position: player.position,
          user: player.user.handle,
        }
      },
    }.to_json(*x)
  end

  private

  attr_reader :game, :current_user

  def players
    # todo - eager-load the associated User.
    game.players.order(:position)
  end
end
