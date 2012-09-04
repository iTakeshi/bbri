class ReviewsUsers < ActiveRecord::Base
  attr_accessible :eval, :review_id, :user_id
end
