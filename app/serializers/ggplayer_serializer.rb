class GgplayerSerializer < ActiveModel::Serializer
  attributes :matches_count, :hours_played, :most_played_race, :highest_league_type, :highest_league_rank, :solo_league, :solo_rank, :twos_league, :twos_rank, :threes_league, :threes_rank, :fours_league, :fours_rank, :achievement_points, :season_games, :career_games, :apm, :ggsiteid
end
