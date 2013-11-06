OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, 513963515360226, '33068b37725db803e4cffa2ee1e26db1'
  elsif Rails.env.development?
    provider :facebook, 595637847160806, 'fbf5263cc6e5db1d75eb21214844d135'
  end
end