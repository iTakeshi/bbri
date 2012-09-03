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
end
