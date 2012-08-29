class UsersController < ApplicationController

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
      # TODO email confirmation
      redirect_to '/'
    else
      render :new
    end
  end
end
