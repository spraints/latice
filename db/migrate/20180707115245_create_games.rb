class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      # state is "playing", "completed", etc.
      t.string :state, index: true

      # identifier is a slug or UUID or something unique.
      # I don't want to use the sequential ID in URLs.
      t.string :identifier, unique: true
      t.index :identifier, unique: true

      t.timestamps
    end
  end
end
