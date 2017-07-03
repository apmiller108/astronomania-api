module Importer
  class ApodWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'
    sidekiq_options retry: false

    def perform
      Importer::Apods::Import.call
    end
  end
end
