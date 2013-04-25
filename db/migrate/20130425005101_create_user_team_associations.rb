class CreateUserTeamAssociations < ActiveRecord::Migration
  def change
    create_table :user_team_associations do |t|
      t.references :user
      t.references :team
      t.string :role

      t.timestamps
    end
    add_index :user_team_associations, :user_id
    add_index :user_team_associations, :team_id
  end
end
