class CommentsController < ApplicationController
  before_filter :authorize

  # GET /reviews/:review_id/comments/new
  def new
    @comment = Review.find(params[:review_id]).comments.new
    render :new, layout: false
  end

  # POST /comments/create
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      render json: { status: :success, comment: @comment, user_name: @comment.user.user_name }
    else
      render json: { status: :error }
    end
  end
end
