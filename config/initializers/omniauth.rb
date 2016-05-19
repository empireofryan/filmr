Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['571382846369422'], ENV['502a10d7de0f8e87608a1c9cc885095c']
end