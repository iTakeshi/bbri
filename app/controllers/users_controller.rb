class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create, :confirm]

  # GET /signup
  def new
    @user = User.new
  end

  # POST /signup
  def create
    @user = User.new(params[:user])
    @user.generate_auth_token
    @user.user_status = 1
    if @user.save
      @user.send_signup_confirmation
      redirect_to '/'
    else
      render :new
    end
  end

  # GET /confirm/:user_auth_token
  def confirm
    user = User.find_by_user_auth_token(params[:user_auth_token])
    user.user_status = 0
    user.save!
    flash[:success] = 'Your Email address was successfully confirmed!'
    redirect_to '/'
  end
end
