require 'starcraft'

module Starcraft

  class Player
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
      # ggtracker = Starcraft::GGTracker.new
      # ggtracker.bnet(name, id, realm)
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
      @ggtracker = ggtracker
      @ladders = nil
    end

    

    def get_ladders
      @ladders = basic_ladder_data
    end

    def basic_ladder_data
      data = JSON.parse(RestClient.get("https://us.api.battle.net/sc2/profile/#{@id}/#{@realm}/#{@display_name}/ladders?locale=en_US&apikey=u6asyvg57kuru6gbsu37wxbmfd4djv9y").body)
      ladders = []
      data['currentSeason'].each do |ladder_arr|
        next if ladder_arr['ladder'].length <= 0
        ladder_arr['ladder'].each do |ladder|
          ladder_data = Starcraft::Ladder.new
          ladder['characters'] = ladder_arr['characters']
          ladder_data.basic_ladder ladder
          ladders.push(ladder_data)
        end
      end
      @ladders = ladders
    end

    def full_ladder_data
      data = JSON.parse(RestClient.get("https://us.api.battle.net/sc2/profile/#{@id}/#{@realm}/#{@display_name}/ladders?locale=en_US&apikey=u6asyvg57kuru6gbsu37wxbmfd4djv9y").body)
      ladders = []
      data['currentSeason'].each do |ladder_type|
        ladder_type.each do |ladder|
          ladder[1].each do |this_ladder|
            ladder_data = Starcraft::Ladder.new
            ladder_data.full_ladder(this_ladder['ladderId'])
            ladders.push(ladder_data) if ladder[0] == "ladder" && ladder[1].length > 0
          end
        end
      end
    end
  end

end
