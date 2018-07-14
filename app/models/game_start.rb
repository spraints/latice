class GameStart
  def start_if_all_ready(game)
    new(game).start_if_all_ready
  end

  def initialize(game)
    @game = game
  end

  attr_reader :game

  def start_if_all_ready
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
end
