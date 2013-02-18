class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :type
      t.datetime :date
      t.string :name
      t.references :channel
      t.integer :value1, :default => 0
      t.integer :value2, :default => 0

      t.timestamps
    end
  end
end
