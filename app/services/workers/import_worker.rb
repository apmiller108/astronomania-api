class ImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(import_type)
    case import_type
    when :asteroid
      Importer::Asteroids::Import.call
    when :apod
      Importer::Apods::Import.call
    end
  end
end
