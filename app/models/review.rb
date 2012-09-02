class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :part
  attr_accessible :part_id, :review_text, :review_title, :user_id

  validates :part_id,
    presence: { message: 'Select a part.' }

  validates :user_id,
    presence: true

  validates :review_title,
    presence: { message: 'Enter title.' }

  validates :review_text,
    presence: { message: 'Enter review text.' }
end
