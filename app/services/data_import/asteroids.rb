module DataImport
  class Asteroids
    def self.call
      new.call
    end

    BASE_URL = 'https://api.nasa.gov/neo/rest/v1/neo/browse'.freeze

    def initialize
      @conn = Faraday.new(url: BASE_URL)
      @loader = DataImport::PageLoader.new('asteroid')
      @page_num = 0
      @total_pages = 0
    end

    def call
      response = conn.get do |req|
        req.params[:page] = page_num
        req.params[:size] = 20
        req.params[:api_key] = 'DEMO_KEY'
      end
      process_response response
      # call unless page_num == total_pages
    end

    private

    def json(response)
      JSON.parse(response.body)
    end

    def process_response(response)
      parsed_body = json(response)
      update_pagination parsed_body
      @loader.process parsed_body['near_earth_objects']
    end

    def update_pagination(response_body)
      self.page_num = response_body['page']['number']
      self.total_pages = response_body['page']['total_pages']
    end

    attr_reader :conn
    attr_accessor :page_num, :total_pages
  end
end
