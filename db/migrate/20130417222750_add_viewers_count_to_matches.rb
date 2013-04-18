class AddViewersCountToMatches < ActiveRecord::Migration
  def change
    change_table(:matches) do |t|
      t.integer :viewers_count, default: 0
    end
  end
end
