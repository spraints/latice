class CreateTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tiles do |t|
      t.belongs_to :game, foreign_key: true, index: true

      # Identifier is a machine-readable reference to the tile.
      # It'll be something like "wind" or "navy-dolphin".
      t.string :identifier

      # If the tile belongs to a player, it'll have a value here.
      t.belongs_to :player, foreign_key: true

      # If the tile belongs to a player, it'll either be in the pool
      # (true) or on the rack (false).
      t.boolean :pool

      # If the tile is played, it'll have coordinates an no player ID.
      t.integer :board_x
      t.integer :board_y

      # If this is a wind tile that's been played, all of the fields
      # above will be blank.

      t.timestamps
    end
  end
end
