# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TreasureHunt
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app/serializers')
  end
end
