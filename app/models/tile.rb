class Tile < ApplicationRecord
  WIND = "wind".freeze
  SHAPES = %w(bird gecko turtle feather flower dolphin).map(&:freeze).freeze
  COLORS = %w(yellow navy magenta red green teal).map(&:freeze).freeze

  belongs_to :game
  belongs_to :player, optional: true

  scope :wind, -> { where(identifier: WIND) }
  scope :not_wind, -> { where("identifier <> ?", WIND) }
end
