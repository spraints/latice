class CreateTurns < ActiveRecord::Migration[5.2]
  def change
    # A turn is a collection of moves.
    create_table :turns do |t|
      t.belongs_to :game, foreign_key: true, index: true
      t.belongs_to :player, foreign_key: true

      # Each player has an independent sequence of turns.
      # In other words, each player will have a turn 1, each
      # will have a turn 2, etc.
      t.integer :sequence

      t.timestamps
    end
  end
end
