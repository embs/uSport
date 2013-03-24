class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :number
      t.references :team

      t.timestamps
    end
    add_index :players, :first_name
  end
end
