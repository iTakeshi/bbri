class UserMailer < ActionMailer::Base
  default from: 'biobrick.reviews.issues@gmail.com'

  def confirm_signup(user)
    @user = user
    @server_name = APP_CONFIG['server_name']
    mail to: @user.user_email, subject: 'Biobrick R&I: Signup successful!'
  end

  def confirm_resetting_password(user)
    @user = user
    @server_name = APP_CONFIG['server_name']
    mail to: @user.user_email, subject: 'Biobrick R&I: Password resetted.'
  end
end
