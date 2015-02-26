require 'starcraft'

module Starcraft

  class Team
    attr_accessor :character, :timestamp, :points, :wins, :losses, :highest_rank, :previous_rank, :favorite_race, :rank

    def initialize data
      basic_data data
    end

    def basic_data data
      @character = data['character']
      @timestamp = data['joinTimestamp']
      @points = data['points']
      @wins = data['wins']
      @losses = data['losses']
      @highest_rank = data['highestRank']
      @previous_rank = data['previousRank']
      @favorite_race = data['favoriteRankP1']
      @rank = data['rank']
    end

  end

end
