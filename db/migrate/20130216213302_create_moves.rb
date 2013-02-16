class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :match
      t.integer :quarter
      t.integer :minute
      t.string :kind
      t.string :description
      t.integer :points
      t.integer :yards
      t.references :player

      t.timestamps
    end
    add_index :moves, :match_id
  end
end
