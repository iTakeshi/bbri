class PartType < ActiveRecord::Base
  has_many :parts
  attr_accessible :type_name

  validates :type_name,
    presence: true,
    uniqueness: true
end
