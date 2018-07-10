class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :game_id, presence: true
  validates :user_id, presence: true
  validates :position, inclusion: { in: (1..4), allow_nil: true }
end
