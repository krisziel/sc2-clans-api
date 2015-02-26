require 'starcraft'

module Starcraft

  class Ladder
    attr_reader :ladder_name, :ladder_id, :division, :rank, :league, :type, :wins, :losses, :showcase, :teams, :characters, :mmq, :id

    def initialize
    end

    def full_ladder id
      # data = JSON.parse(File.read("lib/#{id}.json"))
      data = JSON.parse(RestClient.get("https://us.api.battle.net/sc2/ladder/#{id}?locale=en_US&apikey=u6asyvg57kuru6gbsu37wxbmfd4djv9y").body)
      parse_full_ladder data
    end

    def parse_full_ladder data
      teams = []
      data['ladderMembers'].each do |member|
        profile = Starcraft::Profile.new
        profile.basic_data(member['character'])
        if teams.last && member['joinTimestamp'] == teams.last.timestamp
          teams.last.character.push(profile)
        else
          member['character'] = [profile]
          member['rank'] = teams.length + 1
          team = Starcraft::Team.new(member)
          teams << team
        end
      end
      @teams = teams
    end

    def basic_ladder data
      ladder = data
      @name = ladder['ladderName']
      @id = ladder['ladderId']
      @division = ladder['division']
      @rank = ladder['rank']
      @league = ladder['league']
      @mmq = ladder['matchMakingQueue']
      @wins = ladder['wins']
      @losses = ladder['losses']
      @showcase = ladder['showcase']
      @characters = []
      data['characters'].each do |character|
        profile = Starcraft::Profile.new
        profile.basic_data(character)
        @characters.push(profile)
      end
    end

  end

end
