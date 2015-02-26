class ClanSerializer < ActiveModel::Serializer
  attributes :id, :tag, :name, :players
end
