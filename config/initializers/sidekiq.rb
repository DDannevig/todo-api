Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
  config.redis = { url: 'redis://127.0.0.1:6379' }
end
