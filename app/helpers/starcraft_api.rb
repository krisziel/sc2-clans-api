module StarcraftApi

  class StarcraftPlayer
    attr_reader :id, :realm, :display_name, :clan_name, :clan_tag, :profile_path, :portrait, :career, :season, :campaign, :swarm_levels, :rewards, :achievements, :ladders, :ggtracker

    def basic_data data
      @id = data['id']
      @display_name = data['displayName']
      @realm = data['realm']
      @clan_name = data['clanName']
      @clan_tag = data['clanTag']
      @profile_path = data['profilePath']
    end

    def full_data(name, id, realm, *url)
      data = JSON.parse(RestClient.get("https://us.api.battle.net/sc2/profile/#{id}/#{realm}/#{name}/?locale=en_US&apikey=u6asyvg57kuru6gbsu37wxbmfd4djv9y").body)
      ggtracker = StarcraftApi::StarcraftGGTracker.new.save_player(name, id, realm)
      @display_name = data['displayName']
      @id = data['id']
      @realm = data['realm']
      @clan_name = data['clanName']
      @clan_tag = data['clanTag']
      @profile_path = data['profilePath']
      @portrait = data['portrait']
      @career = data['career']
      @season = data['season']
      @campaign = data['campaign']
      @swarm_levels = data['swarmLevels']
      @rewards = data['rewards']
      @achievements = data['achievements']
      @ggtracker = ggtracker.id
      @ladders = nil
    end

    def save_player(name, bnetid, realm)
      players = Player.where(bnet_id: bnetid)
      if players.length == 0
        full_data(name,bnetid,realm)
        ggplayer = Ggplayer.where(bnetid:bnetid)[0]
        save_player = Player.new(ggplayer_id:ggtracker,clan_tag:@clan_tag,name:@display_name,bnet_id:@id,region:@realm,career:@career.to_json,season:@season.to_json,highest_solo:@career["highest1v1Rank"],highest_team:@career["highestTeamRank"],terran_level:@swarm_levels["terran"]["level"],zerg_level:@swarm_levels["zerg"]["level"],protoss_level:@swarm_levels["protoss"]["level"])
        save_player.save
        player = save_player
        ggplayer.update(player_id:player.id)
      elsif ((Time.now.to_i - players[0].updated_at.to_i) > 84600)
        full_data(name,bnetid,realm)
        ggplayer = Ggplayer.where(bnetid:bnetid)[0]
        player = players[0]
        update_player = player.update(career:@career.to_json,season:@season.to_json,highest_solo:@career["highest1v1Rank"],highest_team:@career["highestTeamRank"],terran_level:@swarm_levels["terran"]["level"],zerg_level:@swarm_levels["zerg"]["level"],protoss_level:@swarm_levels["protoss"]["level"])
        update_player.save
        player = update_player
        ggplayer.update(player_id:player.id)
      else
        player = players[0]
      end
      identity = {
        :name => player.name,
        :bnet_id => player.bnet_id,
        :realm => player.region,
        :id => player.id
      }
      identity
    end

  end

  class StarcraftGGTracker
    attr_accessor :leagues, :id, :name, :gateway, :matches_count, :hours_players, :race, :league_highest, :league_1v1, :league_2v2, :league_3v3, :league_4v4, :points, :season_games, :career_games, :apm

    def bnet(name, id, realm)
      data = JSON.parse(RestClient.get("http://api.ggtracker.com/api/v1/identities/find.json?profile_url=http://us.battle.net/sc2/en/profile/#{id}/#{realm}/#{name}/").body)
      data
    end

    def save_player(name, id, realm)
      data = StarcraftApi::StarcraftGGTracker.new.bnet(name, id, realm)
      data['stats']['apm']['avg'] ? data['stats']['apm']['avg'].round : nil
      gg_data = {
        :ggsiteid => data['id'],
        :matches_count => data['matches_count'],
        :hours_played => data['hours_played'],
        :most_played_race => data['most_played_race'],
        :highest_league_type => data['current_highest_league'],
        :highest_league_rank => data['current_highest_leaguerank'],
        :solo_league => data['current_league_1v1'],
        :solo_rank => data['current_rank_1v1'],
        :twos_league => data['current_league_2v2'],
        :twos_rank => data['current_rank_2v2'],
        :threes_league => data['current_league_3v3'],
        :threes_rank => data['current_rank_3v3'],
        :fours_league => data['current_league_4v4'],
        :fours_rank => data['current_rank_4v4'],
        :achievement_points => data['achievement_points'],
        :season_games => data['season_games'],
        :career_games => data['career_games'],
        :apm => apm,
        :bnetid => id
      }
      if Ggplayer.where(bnetid: id).length == 1
        player = Ggplayer.where(bnetid:id)[0]
        player.update(gg_data)
        player.save
      else
        player = Ggplayer.new(gg_data)
        player.save
      end
      player
    end

  end

  class Nios
    attr_accessor :tag, :name, :members

    def clan tag
      request = RestClient.get("http://nios.kr/sc2/us/clan/detail/#{tag}", :user_agent => 'Chrome')
      html = Nokogiri::HTML(request.body)
      @members = []
      html.css(".name > a").each do |url|
        member = parse_player(url.attr('href'))
        @members << StarcraftApi::StarcraftPlayer.new.save_player(member[:name],member[:id],member[:realm])
      end
      player = @members[0]
      player = JSON.parse(RestClient.get("https://us.api.battle.net/sc2/profile/#{player[:bnet_id]}/#{player[:realm]}/#{player[:name]}/?locale=en_US&apikey=u6asyvg57kuru6gbsu37wxbmfd4djv9y").body)
      @tag = player["clanTag"]
      @name = player["clanName"]
      if Clan.where(tag:player["clanTag"]).length == 0
        clan = Clan.new(tag:player["clanTag"],name:player["clanName"],region:player["realm"])
        clan.save
        Player.where(clan_tag:player["clanTag"]).update_all(clan_id:clan.id)
      end
    end

    def parse_player url
      if url.class == String
        parts = url.to_s.split("/")
      else
        parts = url.attr("href").split("/")
      end
      profile = {
        :name => parts[-1],
        :realm => parts[-2],
        :id => parts[-3]
      }
    end

  end

end
