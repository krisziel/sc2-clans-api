class LadderSerializer < ActiveModel::Serializer
  attributes :id, :name, :bnet_id, :region, :season, :career, :swarm_levels, :ggplayer
end
