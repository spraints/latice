class Game < ApplicationRecord
  has_many :players

  scope :in_progress, -> { where("state = ? OR state = ?", "playing", "pregame") }
  scope :awaiting_players, -> { where(state: "pregame") }

  def self.create(attrs = {})
    super(attrs.reverse_merge(state: "pregame", identifier: SecureRandom.hex(3)))
  end

  def to_param
    identifier
  end
end
