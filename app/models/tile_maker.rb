# Makes tiles for a brand new game.
class TileMaker
  def self.make_tiles!(game)
    new(game).make_tiles!
  end

  def initialize(game)
    @game = game
  end

  def make_tiles!
    12.times do
      game.tiles.create! identifier: Tile::WIND
    end

    Tile::COLORS.each do |color|
      Tile::SHAPES.each do |shape|
        2.times do
          game.tiles.create! identifier: "#{color}-#{shape}"
        end
      end
    end
  end

  attr_reader :game
end
