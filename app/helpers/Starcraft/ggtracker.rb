require 'starcraft'

module Starcraft

  class GGTracker
    attr_accessor :id, :name, :gateway, :matches_count, :hours_players, :race, :league_highest, :league_1v1, :league_2v2, :league_3v3, :league_4v4, :points, :season_games, :career_games, :apm
    @leagues = {
      0 => "bronze",
      1 => "silver",
      2 => "gold",
      3 => "platinum",
      4 => "diamond",
      5 => "master",
      6 => "grandmaster"
    }

    def ggid id
      data = JSON.parse(RestClient.get("http://api.ggtracker.com/api/v1/identities/#{ggid}.json"))
      if data['name']
        parse_data data
      end
    end

    def bnet(name, id, realm)
      data = JSON.parse(RestClient.get("http://api.ggtracker.com/api/v1/identities/find.json?profile_url=http://us.battle.net/sc2/en/profile/#{id}/#{realm}/#{name}/").body)
      data
    end

    def get_identity data
      @leagues = ["bronze","silver","gold","platinum","diamond","master","grandmaster"]
      @id = data['id']
      @name = data['name']
      @gateway = data['gateway']
      @matches_count = data['matches_count']
      @hours_played = data['hours_played'].round
      @race = data['most_played_race']
      if data['current_highest_type']
        @league_highest = {
          :type => data['current_highest_type'],
          :league => @leagues[data['current_highest_league']],
          :rank => data['current_highest_type']
        }
      end
      if data['current_league_1v1']
        @league_1v1 = {
          :league => @leagues[data['current_league_1v1']],
          :rank => data['current_rank_1v1']
        }
      end
      if data['current_league_2v2']
        @league_2v2 = {
          :league => @leagues[data['current_league_2v2']],
          :rank => data['current_rank_2v2']
        }
      end
      if data['current_league_3v3']
        @league_3v3 = {
          :league => @leagues[data['current_league_3v3']],
          :rank => data['current_rank_3v3']
        }
      end
      if data['current_league_4v4']
        @league_4v4 = {
          :league => @leagues[data['current_league_4v4']],
          :rank => data['current_rank_4v4']
        }
      end
      @points = data['achievement_points']
      @season_games = data['season_games']
      @career_games = data['career_games']
      @apm = data['stats']['apm']['avg'].round
    end

  end

end
