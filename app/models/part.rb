class Part < ActiveRecord::Base
  attr_accessible :part_identifier, :part_type_id, :part_year, :team_id
end
