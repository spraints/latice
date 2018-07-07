class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    # A move is a part of a turn.
    create_table :moves do |t|
      t.belongs_to :game, foreign_key: true, index: true
      t.belongs_to :turn, foreign_key: true

      # Each turn has its own sequence. We could use the DB's ID, but
      # I want to explicitly track the sequence of moves.
      t.integer :sequence

      # Details contains a serialized object that says what happened.
      # A move can be an exchange of tiles between the pool and rack,
      # or playing a tile, or purchasing a wind tile.
      t.string :details

      t.timestamps
    end
  end
end
