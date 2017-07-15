module Importer
  OBJECT_TYPES = {
    asteroid: Importer::Asteroids::ObjectLoader,
    apod: Importer::Apods::ObjectLoader
  }.freeze

  WORKERS = {
    asteroid: Importer::AsteroidWorker,
    apod: Importer::ApodWorker
  }.freeze
end
