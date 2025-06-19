Rails.application.configure do
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.mailgun_settings = {
    api_key: ENV["MAILGUN_API_KEY"],
    domain: "tdooner.com"
    # timeout: 20 # Default depends on rest-client, whose default is 60s. Added in 1.2.3.
  }
end
