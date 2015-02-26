class Player < ActiveRecord::Base
  attr_accessor :swarm_levels, :ggplayer

  belongs_to :clan
  has_one :ggplayer
  has_many :teams, through: :team_members

  def profile
    self.career = JSON.parse(self.career) if self.career.class == String
    self.season = JSON.parse(self.season) if self.season.class == String
    self.swarm_levels = {
      :terran => self.terran_level,
      :zerg => self.zerg_level,
      :protoss => self.protoss_level
    }
    self.ggplayer = Ggplayer.select(:matches_count, :hours_played, :most_played_race, :highest_league_type, :highest_league_rank, :solo_league, :solo_rank, :twos_league, :twos_rank, :threes_league, :threes_rank, :fours_league, :fours_rank, :achievement_points, :season_games, :career_games, :apm, :ggsiteid).find(self.ggplayer_id)
    self
  end

end
