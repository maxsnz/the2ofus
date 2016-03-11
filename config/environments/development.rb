The2ofus::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  # config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  
  # tmp dir for cache must be setup outside virtualbox shared folder for sass cached sprites to work
  # config.assets.configure do |env|
  #   env.cache = ActiveSupport::Cache::FileStore.new('/mnt/tmp')
  # end
  # Rails.configuration.mysettings = {}
  # Rails.configuration.mysettings['ga'] = {}
  # Rails.configuration.mysettings['ga']['id'] = 'UA-74410761-1'
  
  # Rails.configuration.mysettings['facebook'] = {}
  # Rails.configuration.mysettings['facebook']['id'] = '138198596570030'
  # Rails.configuration.mysettings['facebook']['secret'] = '7031a77de59086c9064de44eb0624c36'
  # Rails.configuration.mysettings['facebook']['options'] = {}
  # Rails.configuration.mysettings['facebook']['options']['scope'] = 'email'
  # Rails.configuration.mysettings['facebook']['options']['info_fields'] = 'name,email'

  # Rails.configuration.mysettings['vkontakte'] = {}
  # Rails.configuration.mysettings['vkontakte']['id'] = '5328505'
  # Rails.configuration.mysettings['vkontakte']['secret'] = 't9nNI2N7Jf0Ib26tP8TG'
  # Rails.configuration.mysettings['vkontakte']['options'] = {}
  # Rails.configuration.mysettings['vkontakte']['options']['scope'] = 'notify'

  # Rails.configuration.mysettings['instagram'] = {}
  # Rails.configuration.mysettings['instagram']['id'] = '0'
  # Rails.configuration.mysettings['instagram']['secret'] = '0'
  # Rails.configuration.mysettings['instagram']['kyes'] = false


  config.react.variant = :development
  
end
