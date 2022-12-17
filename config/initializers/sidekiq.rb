# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.logger.level = ENV.fetch('LOG_LEVEL', :debug)
  Rails.logger.level = ENV.fetch('LOG_LEVEL', :debug)

  config.on(:startup) do
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end
