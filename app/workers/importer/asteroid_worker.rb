module Importer
  class AsteroidWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'
    sidekiq_options retry: false

    def perform
      Importer::Asteroids::Import.call
    end
  end
end
