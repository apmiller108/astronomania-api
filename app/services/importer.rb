module Importer
  OBJECT_LOADERS = {
    asteroid: Importer::Asteroids::ObjectLoader,
    apod: Importer::Apods::ObjectLoader
  }.freeze

  WORKERS = {
    asteroid: Importer::AsteroidWorker,
    apod: Importer::ApodWorker
  }.freeze
end
