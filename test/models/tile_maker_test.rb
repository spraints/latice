require 'test_helper'

class TileMakerTest < ActiveSupport::TestCase
  setup do
    @game = Game.create!
    users(:one, :two).each do |user|
      @game.players.create!(user: user)
    end
    TileMaker.make_tiles! @game
    @game.reload
  end

  test "adds tiles" do
    assert_equal 84, @game.tiles.size
  end

  test "adds the right tiles" do
    assert_equal({
      "wind" => 12,

      "yellow-bird" => 2,
      "yellow-gecko" => 2,
      "yellow-turtle" => 2,
      "yellow-feather" => 2,
      "yellow-flower" => 2,
      "yellow-dolphin" => 2,

      "navy-bird" => 2,
      "navy-gecko" => 2,
      "navy-turtle" => 2,
      "navy-feather" => 2,
      "navy-flower" => 2,
      "navy-dolphin" => 2,

      "magenta-bird" => 2,
      "magenta-gecko" => 2,
      "magenta-turtle" => 2,
      "magenta-feather" => 2,
      "magenta-flower" => 2,
      "magenta-dolphin" => 2,

      "red-bird" => 2,
      "red-gecko" => 2,
      "red-turtle" => 2,
      "red-feather" => 2,
      "red-flower" => 2,
      "red-dolphin" => 2,

      "green-bird" => 2,
      "green-gecko" => 2,
      "green-turtle" => 2,
      "green-feather" => 2,
      "green-flower" => 2,
      "green-dolphin" => 2,

      "teal-bird" => 2,
      "teal-gecko" => 2,
      "teal-turtle" => 2,
      "teal-feather" => 2,
      "teal-flower" => 2,
      "teal-dolphin" => 2,
    }, @game.tiles.group(:identifier).count)
  end
end
