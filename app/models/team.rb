class Team < ActiveRecord::Base
  has_many :parts
  has_many :users
  attr_accessible :team_name

  validates :team_name,
    presence: true,
    uniqueness: true
end
