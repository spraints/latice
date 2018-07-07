class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    # A player is a user's presence in a game.
    create_table :players do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :game, foreign_key: true, index: true

      # your sequence in the game
      t.integer :position

      # in the future, I might want to track the state here, too,
      # so that I can find the current active games without needing
      # to join the games table.

      t.timestamps
    end
  end
end
