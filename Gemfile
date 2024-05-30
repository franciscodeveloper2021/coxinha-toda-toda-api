source "https://rubygems.org"

gem "awesome_print"
gem "bootsnap", require: false
gem "devise", "~> 4.8"
gem "devise-jwt"
gem "i18n", "~> 1.8"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "sorbet-runtime"
gem "rack-cors"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

group :development, :test do
  gem "byebug"
  gem "debug", platforms: [:mri, :mswin, :mswin64, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 5.0.0"
  gem "shoulda-matchers"
  gem "tapioca", require: false
end

group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "sorbet"
  gem "spring"
  gem "spring-commands-rspec"
end
