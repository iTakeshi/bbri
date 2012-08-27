class Team < ActiveRecord::Base
  has_many :parts
  attr_accessible :team_name

  validates :team_name,
    presence: true,
    uniqueness: true
end
