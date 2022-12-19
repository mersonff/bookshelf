# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'devise_token_auth'
gem 'dotenv-rails', '~> 2.7.6'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.4'
gem 'redis-rails'
gem 'redis-store', '>= 1.4', '< 2'
gem 'sidekiq', '~> 6.5.6'
gem 'sidekiq-scheduler'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'unicorn', '~> 6.1.0'

group :development, :test do
  gem 'byebug'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.21.0'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'rubocop'
  gem 'rubocop-rails', '~> 2.16', '>= 2.16.1'
  gem 'rubocop-rspec', '~> 2.13', '>= 2.13.2'
  gem 'shoulda-matchers', '~> 5.1.0'
end

group :development do
  gem 'listen'
  gem 'spring'
end

group :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'database_cleaner-active_record', '~> 2.0.1'
  gem 'simplecov', require: false
end
