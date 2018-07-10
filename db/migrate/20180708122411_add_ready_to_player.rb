class AddReadyToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :ready, :boolean
  end
end
