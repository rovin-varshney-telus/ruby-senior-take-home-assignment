require 'redis'

module Vandelay
  module Util
    class Cache

      def initialize(key)
        config = Vandelay.config.dig('persistence', 'redis')
        @redis_client = Redis.new(host: config['host'])
        @key = key
        @expire_in = config['expires_in'].to_i
      end

      def get_val
        @redis_client.get(@key)
      end

      def set_val(val)
        @redis_client.setex(@key, @expire_in, val.to_json)
        val
      end

    end
  end
end
