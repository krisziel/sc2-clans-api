class Team < ActiveRecord::Base
  has_many :players, through: :team_members
  belongs_to :ladder
end
