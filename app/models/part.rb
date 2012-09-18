class Part < ActiveRecord::Base
  belongs_to :team
  belongs_to :part_type
  has_many :reviews
  attr_accessible :part_identifier, :part_type_id, :part_year, :team_id, :part_description

  validates :team_id,
    presence: true

  validates :part_type_id,
    presence: true

  validates :part_year,
    presence: true

  validates :part_identifier,
    presence: true,
    uniqueness: true,
    format: { with: /^BBa_[A-Z]\d{3,7}$/ }
end
