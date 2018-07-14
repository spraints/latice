class GameStart
  def self.start_if_all_ready(game)
    new(game).start_if_all_ready
  end

  def initialize(game)
    @game = game
  end

  attr_reader :game

  def players
    @players ||= game.players.to_a
  end

  def random_wind?
    # todo - make this a game option. "random_wind" means that wind tiles are
    # distributed like any other. not "random_wind" means that each player gets
    # an equal number of wind tiles to start.
    false
  end

  def start_if_all_ready
    if players.all?(&:ready?)
      set_state
      assign_positions
      assign_tiles
    end
  end

  def set_state
    game.state = "playing"
    game.save!
  end

  def assign_positions
    players.shuffle.each_with_index do |player, i|
      player.position = i + 1
      player.save!
    end
  end

  def assign_tiles
    tiles = game.tiles
    tiles.update_all \
      player_id: nil,
      pool: true,
      board_x: nil,
      board_y: nil

    # Player -> [Tile, ...]
    player_tiles = Hash.new { |h,k| h[k] = [] }
    unless random_wind?
      distribute_tiles(player_tiles, tiles.wind)
      tiles = tiles.not_wind
    end
    distribute_tiles(player_tiles, tiles)

    player_tiles.each do |player, tiles|
      Tile.where(id: tiles.map(&:id)).update_all player_id: player.id
    end
  end

  def distribute_tiles(player_tiles, tiles)
    tiles = tiles.to_a.shuffle
    until tiles.empty?
      players.each do |player|
        player_tiles[player] << tiles.shift
      end
    end
  end
end
