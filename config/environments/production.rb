require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Disable code reloading between requests for performance.
  config.enable_reloading = false

  # Eager load code on boot for better performance.
  config.eager_load = true

  # Determines whether detailed error pages are displayed for local requests.
  config.consider_all_requests_local = false

  # Specify the local storage service for uploaded files.
  config.active_storage.service = :local

  # Force SSL for secure communication.
  config.force_ssl = true

  # Log to STDOUT with tagged logging.
  config.logger = ActiveSupport::Logger.new($stdout)
                                      .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
                                      .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [ :request_id ]

  # Set log level to "info" to include generic system operation information.
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Enable locale fallbacks for I18n.
  config.i18n.fallbacks = true

  # Disable logging of deprecations.
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Store files on Amazon S3
  config.active_storage.service = :amazon

  # Specify the default URL host for Rails routes
  Rails.application.routes.default_url_options[:host] = 'your-domain.com'
end
