# frozen_string_literal: true
class Throttler
  REQUEST_LIFE = 1.hour
  MAX_REQUESTS = 20

  attr_reader :email, :redis

  def initialize(email, redis_store = RedisStore.instance)
    @email = email
    @redis = redis_store.redis
  end

  def requested!
    redis.sadd(email_key, hashified_email)
    redis.expire(email_key, REQUEST_LIFE)

    redis.set(hashified_email_key, true, ex: REQUEST_LIFE)
  end

  def max_reached?
    clean_old_keys!
    redis.scard(email_key) >= MAX_REQUESTS
  end

  private

  def hashified_email
    return @hashified_email if @hashified_email.present?

    loop do
      @hashified_email = email + SecureRandom.base64
      break unless redis.sismember(email_key, @hashified_email)
    end

    @hashified_email
  end

  def clean_old_keys!
    old_keys = requests_keys.select { |key| !redis.exists(keyify(key)) }
    redis.srem email_key, old_keys if old_keys.present?
  end

  def requests_keys
    redis.sscan(email_key, 0, count: 21)[1]
  end

  def hashified_email_key
    keyify(hashified_email)
  end

  def email_key
    keyify(email)
  end

  def keyify(key)
    "email:#{key}"
  end
end
