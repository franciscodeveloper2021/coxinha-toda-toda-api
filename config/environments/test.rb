require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Disable reloading for test environment since files aren't watched during tests.
  config.enable_reloading = false

  # Enable eager loading in CI environments to ensure it's working properly before deployment.
  config.eager_load = ENV["CI"].present?

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.hour.to_i}" }

  # Show full error reports and disable caching for easier debugging.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Render exception templates for rescuable exceptions and raise for other exceptions.
  config.action_dispatch.show_exceptions = :rescuable

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory for testing.
  config.active_storage.service = :test

  # Configure Action Mailer to accumulate sent emails in the deliveries array for testing.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to stderr.
  config.active_support.deprecation = :stderr

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Store uploaded files on the local file system in a temporary directory for testing.
  config.active_storage.service = :test

  # Specify the default URL host for Rails routes
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
end
