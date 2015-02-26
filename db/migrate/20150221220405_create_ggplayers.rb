class CreateGgplayers < ActiveRecord::Migration
  def change
    create_table :ggplayers do |t|
      t.integer :player_id
      t.integer :matches_count
      t.integer :hours_played
      t.string :most_played_race
      t.integer :highest_league_type
      t.integer :highest_league_rank
      t.integer :solo_league
      t.integer :solo_rank
      t.integer :twos_league
      t.integer :twos_rank
      t.integer :threes_league
      t.integer :threes_rank
      t.integer :fours_league
      t.integer :fours_rank
      t.integer :achievement_points
      t.integer :season_games
      t.integer :career_games
      t.integer :apm
      t.integer :bnetid
      t.string :portrait
      t.timestamps
    end
  end
end
