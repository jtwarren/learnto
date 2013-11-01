OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 513963515360226, '33068b37725db803e4cffa2ee1e26db1'
end