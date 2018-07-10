class Game < ApplicationRecord
  has_many :players

  scope :in_progress, -> { where("state = ? OR state = ?", "playing", "pregame") }
  scope :awaiting_players, -> { where(state: "pregame") }

  def pregame!
    raise "Not in pre-game!" unless state == "pregame"
  end

  def not_full!
    raise "Game is full!" if full?
  end

  def full?
    players.size > 3
  end

  def self.create(attrs = {})
    super(attrs.reverse_merge(state: "pregame", identifier: SecureRandom.hex(3)))
  end

  def to_param
    identifier
  end
end
