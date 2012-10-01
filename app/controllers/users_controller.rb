class UsersController < ApplicationController
  before_filter :authorize, except: [:new, :create, :confirm, :reset_password, :send_new_password]

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
    redirect_to '/login'
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

  # GET /signout
  def signout
  end

  # DELETE /signout
  def delete
    user = current_user
    if user.user_email == params[:user_email] && user.authenticate(params[:password])
      if params[:confirm_deletion]
        user.reviews.each do |review|
          review.delete
        end
        user.delete
        session[:user_auth_token] = nil
        cookies.delete(:remember_me)
        flash[:alert] = 'Account deleted.'
        redirect_to '/'
      else
        @error_msg = 'check "Are you sure to signout?"'
        render :signout
      end
    else
      @error_msg = 'Invalid email address or password.'
      render :signout
    end
  end

  # GET /reset_password
  def reset_password
  end

  # POST /reset_password
  def send_new_password
    user = User.find_by_user_email(params[:user_email])
    user.password = SecureRandom.hex(4)
    user.save!
    user.send_resetting_password_confirmation
    flash[:info] = 'Password resetting notification was successfully sent.'
    redirect_to '/login'
  end
end
