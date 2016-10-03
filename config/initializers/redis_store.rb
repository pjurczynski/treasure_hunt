# frozen_string_literal: true
require 'redis-namespace'

class RedisStore
  include Singleton

  attr_reader :redis

  def initialize
    @connection = Redis.new
    @redis = Redis::Namespace.new(
      Rails.application.secrets.redis_namespace,
      redis: @connection,
    )
  end
end
