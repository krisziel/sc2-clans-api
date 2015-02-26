class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.integer :player_id
      t.integer :team_id
      t.timestamps
    end
  end
end
