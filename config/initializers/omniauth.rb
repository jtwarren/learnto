OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 595637847160806, 'fbf5263cc6e5db1d75eb21214844d135'
end