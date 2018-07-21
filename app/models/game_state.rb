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
      current_player: current_player && player_json(current_player),
      players: players.map { |player| player_json(player) },
      racked_tiles: current_player && current_player.tiles.in_rack.map { |tile| tile_json(tile) },
      board: board_json,
      urls: urls,
    }.to_json(*x)
  end

  private

  attr_reader :game, :current_user

  def urls
    playing = !!current_player
    numplayers = players.size
    {}.tap do |urls|
      if playing
        urls[:player] = "/games/#{game.to_param}/players/#{current_player.id}"
        if numplayers > 1
          urls[:ready] = "/games/#{game.to_param}/players/#{current_player.id}/ready"
        end
      elsif game.state == "pregame" && !game.full?
        urls[:join] = "/games/#{game.to_param}/players"
      end
    end
  end

  def player_json(player)
    {
      id: player.id,
      position: player.position,
      user: player.user.handle,
      ready: player.ready?,
      tile_counts: {
        in_rack: player.tiles.in_rack.size,
        total: player.tiles.size,
      },
    }
  end

  def tile_json(tile)
    {
      id: tile.id,
      identifier: tile.identifier,
    }
  end

  def board_json
    (1..9).map { |row| {
      row: row,
      cells: (1..9).map { |col| cell_json(row: row, col: col) },
    } }
  end

  def cell_json(row:, col:)
    {
      row: row,
      col: col,
      sun: sun?(row: row, col: col),
      moon: row == 5 && col == 5,
    }
  end

  def sun?(row:, col:)
    case row
    when 1, 9
      col == 1 || col == 5 || col == 9
    when 2, 8
      col == 2 || col == 8
    when 3, 7
      col == 3 || col == 7
    when 5
      col == 1 || col == 9
    end
  end

  def players
    # todo - eager-load the associated User.
    @players ||= game.players.order(:position).includes(:user)
  end

  def current_player
    return @current_player if defined? @current_player
    @current_player = players.where(user_id: current_user.id).first
  end
end
