class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :channels, :user_id
    add_attachment :channels, :avatar
  end
end
