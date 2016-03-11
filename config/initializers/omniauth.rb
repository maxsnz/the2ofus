OmniAuth.config.path_prefix = "/auth"

Rails.application.config.middleware.use OmniAuth::Builder do
  %w{instagram facebook vkontakte}.each do |name|
    settings = Apps[name]
    keys = settings['keys'] || %w{id secret options}
    provider name, *keys.map { |k| settings[k] }
  end
end
