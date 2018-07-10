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
          id: player.id,
          position: player.position,
          user: player.user.handle,
          ready: player.ready?,
        }
      },
      urls: urls,
    }.to_json(*x)
  end

  private

  attr_reader :game, :current_user

  def urls
    {}.tap do |urls|
      if current_player
        urls[:player] = "/games/#{game.to_param}/players/#{current_player.id}"
      elsif game.state == "pregame" && !game.full?
        urls[:join] = "/games/#{game.to_param}/players"
      end
    end
  end

  def players
    # todo - eager-load the associated User.
    game.players.order(:position)
  end

  def current_player
    players.where(user_id: current_user.id).first
  end
end
