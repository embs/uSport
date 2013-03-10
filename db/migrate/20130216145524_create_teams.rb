class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :sport_type
      t.boolean :is_official, :default => false

      t.timestamps
    end
    add_attachment :teams, :avatar
  end
end
