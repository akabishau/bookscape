module CacheScenarios
  BOOK_SEARCH = :book_search
end

class CacheService
  def self.cache(user, scenario, value)
    raise "Caching is not enabled. Run \"rails dev:cache\" to configure dev env" unless cache_enabled?

    key = generate_key(user, scenario)
    case scenario
    when CacheScenarios::BOOK_SEARCH
      Rails.cache.write(key, value, expires_in: 1.hour)
    else
      raise "Unknown caching scenario: #{scenario}"
    end
    Rails.logger.info("FOR KEY: #{key}, WRITING TO CACHE: #{value}")
  end

  def self.fetch(user, scenario)
    raise "Caching is not enabled. Run \"rails dev:cache\" to configure dev env" unless cache_enabled?

    key = generate_key(user, scenario)
    value = Rails.cache.read(key)
    Rails.logger.info("FOR KEY: #{key}, READING FROM CACHE: #{value}")
    value
  end

  private_class_method :generate_key, :cache_enabled?

  def self.generate_key(user, scenario)
    [user.id, scenario].join("_")
  end

  def self.cache_enabled?
    !Rails.cache.instance_of?(ActiveSupport::Cache::NullStore)
  end
end
