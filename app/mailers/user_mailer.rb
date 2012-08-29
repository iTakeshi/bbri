class UserMailer < ActionMailer::Base
  default from: 'biobrick.reviews.issues@gmail.com'
  require '/var/app/setting/bbri/server_name.rb'

  def confirm_signup(user)
    @user = user
    @server_name = bbri_server_name
    mail to: @user.user_email, subject: 'Biobrick R&I: Signup successful!'
  end
end
