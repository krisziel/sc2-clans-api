require 'starcraft'

module Starcraft
  class Nios
    attr_accessor :tag, :name, :html, :members

    def clan tag
      @tag = tag
      request = RestClient.get("http://nios.kr/sc2/us/clan/detail/#{tag}", :user_agent => 'Chrome')
      @html = Nokogiri::HTML(request.body)
      # @name = Starcraft::SC2Ranks.new(tag).name
      @members = []
      @html.css(".name > a").each do |url|
        @members.push(parse_player url)
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

    def get_profiles
      members = []
      @members.each do |member|
        profile = Starcraft::Profile.new
        profile.full_data(member[:name], member[:id], member[:realm])
        members.push(profile)
      end
      @members = members
    end

  end
end
