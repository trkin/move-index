require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MoveIndex
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    ActionView::Base.raise_on_missing_translations = true
    config.action_mailer.delivery_method = :smtp
    config.active_job.queue_adapter = :sidekiq
    # also check config/initializers/const.rb
    I18n.available_locales = %i[en sr sr-latin]
  end
end
