class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :part
  has_many :good_to_reviews
  attr_accessible :part_id, :review_text, :review_title, :user_id, :is_question

  validates :part_id,
    presence: { message: 'Select a part.' }

  validates :user_id,
    presence: true,
    uniqueness: { scope: :part_id, unless: :is_question, on: :create }

  validates :review_title,
    presence: { message: 'Enter title.' }

  validates :review_text,
    presence: { message: 'Enter review text.' }
end
