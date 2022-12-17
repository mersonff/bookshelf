# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookshelf
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.log_level = :debug
    config.log_tags  = %i[subdomain uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new($stdout))

    config.cache_store = :redis_store, ENV.fetch('CACHE_URL', nil),
                         { namespace: 'bookshelf::cache' }

    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
  end
end
