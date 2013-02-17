class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :type
      t.datetime :date
      t.string :name
      t.references :channel
      t.integer :value1
      t.integer :value2

      t.timestamps
    end
  end
end
