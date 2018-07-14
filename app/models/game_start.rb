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

  def start_if_all_ready
    if players.all?(&:ready?)
      set_state
      assign_positions
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
end
