class ReviewsController < ApplicationController

  # GET /reviews
  def index
    @random_reviews = Review.order('RANDOM()').limit(25)
    @latest_reviews = Review.order('id DESC').limit(25)
    @hottest_reviews = Review.select('*, good_count / (bad_count + 1) AS score').order('score DESC').limit(10)
  end

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
    user_eval = ReviewsUsers.where(review_id: params[:review_id], user_id: current_user.id).first
    review = Review.find(params[:review_id])
    if user_eval
      if user_eval.eval == 0
        user_eval.eval = 1
        user_eval.save!
        review.increment(:good_count).decrement(:bad_count).save!
        render json: { status: :success, review: review }
      else
        render json: { status: :already, review: review }
      end
    else
      ReviewsUsers.create!(
        review_id: params[:review_id],
        user_id: current_user.id,
        eval: 1
      )
      review.increment(:good_count).save!
      render json: { status: :success, review: review }
    end
  end

  # GET /reviews/:review_id/bad
  def bad
    user_eval = ReviewsUsers.where(review_id: params[:review_id], user_id: current_user.id).first
    review = Review.find(params[:review_id])
    if user_eval
      if user_eval.eval == 1
        user_eval.eval = 0
        user_eval.save!
        review.decrement(:good_count).increment(:bad_count).save!
        render json: { status: :success, review: review }
      else
        render json: { status: :already, review: review }
      end
    else
      ReviewsUsers.create!(
        review_id: params[:review_id],
        user_id: current_user.id,
        eval: 0
      )
      review.increment(:bad_count).save!
      render json: { status: :success, review: review }
    end
  end
end
