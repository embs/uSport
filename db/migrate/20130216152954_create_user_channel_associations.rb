class CreateUserChannelAssociations < ActiveRecord::Migration
  def change
    create_table :user_channel_associations do |t|
      t.references :user, :channel
      t.timestamps
    end
    add_index :user_channel_associations, [:user_id, :channel_id]
  end
end
