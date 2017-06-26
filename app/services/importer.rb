module Importer
  OBJECT_TYPES = {
    asteroid: Importer::Asteroids::ObjectLoader,
    apod: Importer::Apods::ObjectLoader
  }.freeze

  class ApiRequestError < StandardError; end
end
