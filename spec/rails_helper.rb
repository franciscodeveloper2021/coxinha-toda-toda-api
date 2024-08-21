require 'simplecov'

  SimpleCov.start 'rails' do
    add_filter 'channels'
    add_filter 'mailers'
    add_filter 'jobs'
    add_filter 'views'
  end

require 'spec_helper'

  ENV['RAILS_ENV'] = 'test'
  puts "RAILS_ENV: #{ENV['RAILS_ENV']}"
  require_relative '../config/environment'

  abort("The Rails environment is running in production mode!") if Rails.env.production?
  puts "Current Database: #{ActiveRecord::Base.connection.current_database}"

require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'factory_bot_rails'

RSpec.configure do |config|

  config.fixture_path = Rails.root.join('spec/fixtures').to_s

  config.use_transactional_fixtures = false

  config.include FactoryBot::Syntax::Methods

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each, type: :request) do
    Rack::Utils::SYMBOL_TO_STATUS_CODE[:unprocessable_entity] ||= 422
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FileUtils.rm_rf(Dir[Rails.root.join('tmp', 'storage')])
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:each) do
    FileUtils.rm_rf(Dir[Rails.root.join('tmp', 'storage')])
  end
end
