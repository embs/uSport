class CreateMatchesTeams < ActiveRecord::Migration
  def change
    create_table :matches_teams, :id => false do |t|
      t.integer :match_id
      t.integer :team_id
    end
  end
end
