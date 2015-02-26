class PlayerController < ApplicationController
  helper StarcraftApi

  def save_player
    identity = StarcraftApi::StarcraftPlayer.new.save_player(params[:name],params[:bnetid],params[:realm])
    profile(identity[:id])
  end

  def profile *id
    player = Player.find(params[:id] || id)
    player = player[0] if player.class == Array
    player = player.profile
    render json: player
  end

  def ladder
    
    render json: {}
  end

end
