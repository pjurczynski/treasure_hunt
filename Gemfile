# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg'
gem 'puma'
gem 'active_model_serializers'
gem 'activerecord-postgis-adapter'
gem 'dry-types'
gem 'trailblazer'
gem 'trailblazer-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'faker'
  gem 'database_cleaner'
  gem 'pry-rails'
  gem 'pry-doc'
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rails', require: false
  gem 'guard-rubocop'
  gem 'guard-spring', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
end
