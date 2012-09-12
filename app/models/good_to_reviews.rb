class GoodToReviews < ActiveRecord::Base
  belongs_to :review, counter_cache: :good_counter
  attr_accessible :review_id, :user_id

  validates :review_id,
    presence: true,
    uniqueness: { scope: :user_id }

  validates :user_id,
    presence: true
end
