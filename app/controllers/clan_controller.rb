class ClanController < ApplicationController
  helper StarcraftApi

  def info
    clans = Clan.where("LOWER(tag) LIKE '%#{params[:tag].downcase}%'")
    if clans.length > 0
      clan = clans[0]
      members = []
      clan.players.each do |player|
        members.push(player.profile)
      end
      render json: [clan.tag, clan.name, members]
    else
      render json: {
        error: "notfound"
      }
    end
  end

  def create
    clan = StarcraftApi::Nios.new
    clan.clan(params[:tag])
    render json: clan
  end

end
