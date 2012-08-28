class User < ActiveRecord::Base
  attr_accessible :password_digest, :team_id, :user_auth_token, :user_email, :user_name, :user_status
end
