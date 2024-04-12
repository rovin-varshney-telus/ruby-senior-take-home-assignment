require 'spec_helper'
require 'redis'

RSpec.describe 'Vandelay::Util::Cache', type: :service do

  it "should not set the key value" do
    cache = Vandelay::Util::Cache.new('test-key')
    expect(cache.get_val).to eq(nil)
  end

  it "should set the key value" do
    cache = Vandelay::Util::Cache.new('test-key')
    resp = cache.set_val({province: 'QC'})
    expect(resp).to eq({province: 'QC'})
  end

  it "should get the key value" do
    cache = Vandelay::Util::Cache.new('test-key')
    resp = cache.set_val({province: 'QC'})
    expect(cache.get_val).to eq({province: 'QC'}.to_json)
  end

  after do
    # Cleanup test keys
    config = Vandelay.config.dig('persistence', 'redis')
    @redis_client = Redis.new(host: config['host'])
    @redis_client.del('test-key')
  end

end
