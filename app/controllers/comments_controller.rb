class CommentsController < ApplicationController
  before_filter :authorize, except: :index

  # GET /reviews/:review_id/comments
  def index
    @comments = Review.find(params[:review_id]).comments
    render :index, layout: false
  end

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
      render json: { status: :success, comment: @comment, user_name: @comment.user.user_name, time: @comment.created_at.strftime("%Y.%m.%d %H:%M") }
    else
      render json: { status: :error }
    end
  end
end
