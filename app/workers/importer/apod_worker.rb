module Importer
  class ApodWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform
      Importer::Apods::Import.call
    end
  end
end
