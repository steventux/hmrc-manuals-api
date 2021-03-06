require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HMRCManualsAPI
  mattr_accessor :content_register
  mattr_accessor :publishing_api
  mattr_accessor :rummager
  mattr_accessor :content_store

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # We need to put this middleware back, after "rails-api" strips it out.
    # This middleware must be present, otherwise the "request_store" gem, which
    # is a dependency of "logstasher", falls over. It's not clear whether "request_store"
    # actually uses this middleware itself, but it references it in the railtie.
    config.middleware.insert_after(Rack::Runtime, Rack::MethodOverride)

    # Disable Rack::Cache
    config.action_dispatch.rack_cache = nil
  end
end
