class Tile < ApplicationRecord
  WIND = "wind".freeze
  SHAPES = %w(bird gecko turtle feather flower dolphin).map(&:freeze).freeze
  COLORS = %w(yellow navy magenta red green teal).map(&:freeze).freeze

  belongs_to :game
  belongs_to :player, optional: true

  scope :wind, -> { where(identifier: WIND) }
  scope :not_wind, -> { where("identifier <> ?", WIND) }
  scope :in_rack, -> { where("player_id IS NOT NULL AND NOT pool") }

  def wind?
    identifier == WIND
  end

  def shape
    wind? ? nil : identifier.split("-").last
  end

  def color
    wind? ? nil : identifier.split("-").first
  end
end
