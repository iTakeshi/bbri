class Team < ActiveRecord::Base
  attr_accessible :team_name

  validates :team_name,
    presence: true,
    uniqueness: true
end
