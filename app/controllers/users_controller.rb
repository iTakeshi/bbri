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

  # GET /profile
  def edit
    @user = current_user
  end

  # PUT /profile
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:info] = 'Profile updated.'
      redirect_to '/profile'
    else
      render :edit
    end
  end

  # GET /profile/password
  def edit_password
  end

  # POST /profile/password
  def update_password
    user = current_user
    if user.authenticate(params[:current_password])
      if params[:password] == params[:password_confirmation]
        user.password = params[:password]
        user.save!
        flash[:info] = 'Password updated.'
        redirect_to '/profile'
      else
        @error_msg = 'Password confirmation does not match.'
        render action: :edit_password
      end
    else
      @error_msg = 'Invalid current password.'
      render action: :edit_password
    end
  end
end
