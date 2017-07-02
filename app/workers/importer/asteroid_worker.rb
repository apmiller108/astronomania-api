module Importer
  class AsteroidWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform
      Importer::Asteroids::Import.call
    end
  end
end
