class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :type
      t.datetime :date
      t.string :name

      t.timestamps
    end
  end
end
