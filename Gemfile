source "https://rubygems.org"

ruby "3.3.0"

# Core gems
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "i18n", "~> 1.8"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Devise gems
group :devise do
  gem "devise", "~> 4.8"
  gem "devise-jwt"
end

# Development and Test gems
group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "debug", platforms: [:mri, :mswin, :mswin64, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 5.0.0"
end

# Test-only gems
group :test do
  gem "shoulda-matchers"
end

# Development-only gems
group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "rubocop", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec_rails", require: false
  gem "sorbet"
  gem "sorbet-runtime"
  gem "tapioca", require: false
end
