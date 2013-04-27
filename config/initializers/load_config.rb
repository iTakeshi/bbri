APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

Bbri::Application.configure do
  # SMTP server configuration.
  if Rails.env == 'production'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      authentification: :plain,
      enable_starttls_auto: true,
      user_name: APP_CONFIG['gmail']['user'],
      password: APP_CONFIG['gmail']['pass']
    }
  end
end
