require 'rails_helper'

describe 'Player#' do

  it 'Save player and then load it' do
    get '/player/profile/lIBARCODEIl/1/6117903/add'
    player = JSON.parse(response.body)["player"]
    expect(player["name"]).to eq("lIBARCODEIl")
  end

end
