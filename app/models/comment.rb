class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  attr_accessible :comment_text, :good_counter, :review_id

  validates :user_id,
    presence: true

  validates :review_id,
    presence: true

  validates :comment_text,
    presence: { message: "You can't send a blank comment." }

  validates :good_counter,
    presence: true
end
