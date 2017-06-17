module DataImport
  class Asteroids
    def self.call
      new.call
    end

    BASE_URL = 'https://api.nasa.gov/neo/rest/v1/neo/browse'.freeze

    def initialize
      @conn = Faraday.new(url: BASE_URL)
      @loader = DataImport::AsteroidPageLoader.new
      @page_num = 1
      @total_pages = 0
    end

    def call
      response = conn.get do |req|
        req.params[:page] = page_num
        req.params[:size] = 20
        req.params[:api_key] = 'DEMO_KEY'
      end
      p JSON.parse(response.body)
    end

    private

    attr_reader :conn, :page_num, :total_pages
  end
end
