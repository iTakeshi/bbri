class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

private
  def authorize
    unless current_user
      session[:requested_url] = request.url
      redirect_to '/login'
      return
    end
    if cookies[:remember_me] == 'true'
      request.session_options[:expire_after] = 86400 * 30
    end
  end

  def current_user
    if session[:user_auth_token]
      user = User.find_by_user_auth_token(session[:user_auth_token])
      if user.user_status == 0
        user
      elsif user.user_status == 1
        flash[:error] = 'Your Email address has not yet confirmed. Please check your inbox.'
        nil
      elsif user.user_status == 2
        flash[:error] = 'Your account is under password resetting process. If you lost the notification mail, please re-start the process.'
        nil
      end
    else
      nil
    end
  end
end
