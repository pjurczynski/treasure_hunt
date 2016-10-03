# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include ApiControllerExampleGroup,
                 type: :api_controller,
                 file_path: Regexp.new('spec/controllers/api/')

  config.include APIHelpers, type: :api_controller
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation, except: %w(spatial_ref_sys))
    ActiveJob::Base.queue_adapter = :test
    FactoryGirl.find_definitions
  end

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
    RedisStore.instance.redis.flushall
  end
end
