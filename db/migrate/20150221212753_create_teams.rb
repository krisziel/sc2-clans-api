class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :ladder_id
      t.integer :rank
      t.integer :points
      t.integer :wins
      t.integer :losses
      t.string :race
      t.timestamps
    end
  end
end
