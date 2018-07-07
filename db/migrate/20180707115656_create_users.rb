class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # For now, you just have a handle/username/login. I'll add auth later.
      t.string :handle, unique: true
      t.index :handle, unique: true

      t.timestamps
    end
  end
end
