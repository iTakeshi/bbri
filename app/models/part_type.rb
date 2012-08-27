class PartType < ActiveRecord::Base
  attr_accessible :type_name

  validates :type_name,
    presence: true,
    uniqueness: true
end
