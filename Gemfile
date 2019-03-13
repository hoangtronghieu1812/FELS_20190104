source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.0"

gem "rails", "~> 5.2.2"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", ">= 4.2.1"
gem "config"
gem "ffaker"
gem "pagy"
gem "mysql2"
gem "rails-ujs"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "i18n-js"
gem "figaro"
gem "devise", "=4.6.0"
gem "ransack"
gem "font-awesome-rails"
gem "kaminari"
gem "carrierwave"
gem "public_activity"
gem "rails_admin", "=1.4.0"
gem "cancancan", "~> 2.0"
gem "searchkick", "~>3.1.0"
gem "omniauth-google-oauth2", "=0.6.0"
gem "sidekiq", "~>5.2.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "pry"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  gem "pg"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
