class ReviewsController < ApplicationController

  # MATCH /parts/:part_identifier/user_review
  def create_or_update
    review = Review.where(user_id: current_user.id, part_id: Part.find_by_part_identifier(params[:part_identifier]).id).first_or_initialize
    review.review_title = params[:review][:review_title]
    review.review_text = params[:review][:review_text]
    if review.save
      render json: { status: :success, review: review }
    else
      render json: { status: :error }
    end
  end

  # GET /reviews/:review_id/good
  def good
    review = Review.find(params[:review_id])
    existing = GoodToReviews.where(review_id: review.id, user_id: current_user.id).first
    if existing
      existing.delete
      review.increment(:good_counter).save!
    else
      GoodToReviews.create!(review_id: review.id, user_id: current_user.id)
      review.decrement(:good_counter).save!
    end
    render json: { status: :success, good_counter: review.good_counter }
  end
end
