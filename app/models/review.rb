class Review < ActiveRecord::Base
  attr_accessible :part_id, :review_text, :review_title, :user_id
end
