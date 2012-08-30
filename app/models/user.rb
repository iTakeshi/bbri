class User < ActiveRecord::Base
  belongs_to :team
  has_secure_password
  attr_accessible :team_id, :user_email, :user_name, :password, :password_confirmation

  validates :team_id,
    presence: { message: 'Select a team.' }

  validates :team,
    presence: { message: 'The team you selected is not existent.', if: :team_id? }

  validates :user_name,
    presence: { message: 'Enter username.' },
    length: { allow_blank: true, minimum: 3, maximum: 10 },
    uniqueness: { allow_blank: true, message: 'The username you entered is already taken. Enter unique one.' }

  validates :user_email,
    presence: { message: 'Enter Email address.' },
    format: { allow_blank: true, with: /^[^@]{,50}@[a-zA-Z0-9\.\-_]{3,30}$/, message: 'Email has invalid format.' },
    uniqueness: { allow_blank: true, message: 'The Email address you entered is already taken. Enter unique one.' }

  validates :user_auth_token,
    presence: true,
    uniqueness: { allow_blank: true }

  validates :user_status,
    presence: true,
    inclusion: { allow_blank: true, in: [0, 1, 2] }

  validates :password,
    presence: { on: :create, message: 'Enter password.' },
    confirmation: { on: :create, message: 'password confirmation does not match.' }

  def generate_auth_token
    begin
      self.user_auth_token = SecureRandom.urlsafe_base64(20)
    end while User.exists?(user_auth_token: self.user_auth_token)
  end

  def send_signup_confirmation
    UserMailer.confirm_signup(self).deliver
  end

  def send_resetting_password_confirmation
    UserMailer.confirm_resetting_password(self).deliver
  end
end
