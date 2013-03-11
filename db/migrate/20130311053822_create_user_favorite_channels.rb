class CreateUserFavoriteChannels < ActiveRecord::Migration
  def change
    create_table :user_favorite_channels do |t|
      t.references :user, :channel
      t.timestamps
    end
    add_index :user_favorite_channels, [:user_id, :channel_id]
  end
end
