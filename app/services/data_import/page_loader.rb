module DataImport
  class PageLoader
    def initialize(model)
      # @_model = model.capitalize.constantize
      @_model = model.capitalize
    end

    def process(asteroids)
      p asteroids.count
    end
  end
end
