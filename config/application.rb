require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Storm
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.assets.initialize_on_precompile = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Remove rails class added to error fields.
    config.action_view.field_error_proc = Proc.new do |html_tag, _instance|
      html_tag
    end

    # Use DelayedJob as adapter for ActiveJob.
    config.active_job.queue_adapter = :delayed_job

    # Allow GET requests from any origin for API.
    config.middleware.insert_before(0, Rack::Cors) do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get]
      end
    end
  end
end
