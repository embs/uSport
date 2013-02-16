class CreateUserChannelAssociations < ActiveRecord::Migration
  def change
    create_table :user_channel_associations do |t|
      t.integer :user_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
