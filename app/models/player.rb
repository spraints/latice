class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :game_id, presence: true
  validates :user_id, presence: true
  validates :position, presence: true, inclusion: { in: (1..4) }
end
