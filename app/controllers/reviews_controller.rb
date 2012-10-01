class ReviewsController < ApplicationController
  before_filter :authorize, only: [:create_or_update, :good, :my_reviews]

  # GET /reviews
  def index
    if Rails.env == 'production'
      @random_reviews = Review.order('RAND()').limit(25)
    else
      @random_reviews = Review.order('RANDOM()').limit(25)
    end
    @latest_reviews = Review.order('id DESC').limit(25)
    @hottest_reviews = Review.order('good_counter DESC').limit(25)
  end

  # GET /parts/:part_identifier/reviews/new
  def new
    @review = Part.find_by_part_identifier(params[:part_identifier]).reviews.new
    if params[:type] == 'question'
      @review.is_question = true
    else
      @review.is_question = false
    end
    @review_path = "/parts/#{params[:part_identifier]}/reviews/create"
    render :review_form, layout: nil
  end

  # GET /reviews/:review_id/edit
  def edit
    @review = Review.find(params[:review_id])
    @review_path = "/reviews/#{@review.id}/update"
    render :review_form, layout: nil
  end

  # POST /parts/:part_identifier/reviews/create
  def create
    review = Review.new(params[:review])
    review.user_id = current_user.id
    if review.save
      render json: { status: :success, review: review, new_record: :true, part_identifier: review.part.part_identifier, user: review.user.user_name }
    else
      render json: { status: :error }
    end
  end

  # POST /reviews/:review_id/update
  def update
    review = Review.find(params[:review_id])
    review.review_title = params[:review][:review_title]
    review.review_text = params[:review][:review_text]
    if review.save
      render json: { status: :success, review: review, new_record: :false, part_identifier: review.part.part_identifier, user: review.user.user_name }
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
      review.decrement(:good_counter).save!
      operation = 'decrement'
    else
      GoodToReviews.create!(review_id: review.id, user_id: current_user.id)
      review.increment(:good_counter).save!
      operation = 'increment'
    end
    render json: { status: :success, good_counter: review.good_counter, operation: operation }
  end

  # GET /reviews/my_reviews
  def my_reviews
    @user = current_user
    all_reviews = @user.reviews
    @page = ( params[:page] ? params[:page].to_i : 1 )
    @page_max = (all_reviews.count.to_f / 25).ceil
    @reviews = all_reviews.order('id DESC').offset(25 * (@page - 1)).limit(25)
    @pagenation_base_url = "/reviews/my_reviews?page="
  end
end
