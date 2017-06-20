module Importer
  module Asteroids
    class Import
      def self.call
        new.call
      end

      BASE_URL = 'https://api.nasa.gov/neo/rest/v1/neo/browse'.freeze

      def initialize
        @conn = Faraday.new(url: BASE_URL)
        @list_loader = Importer::Asteroids::ListLoader.new
        @page_num = 0
        @total_pages = 0
      end

      def call
        process_response request_page
        if page_num == total_pages
          puts "#{@list_loader.number_successful} processed successfully. "\
              "#{@list_loader.number_failed} failed."
        else
          call
        end
      end

      private

      attr_accessor :page_num, :total_pages

      def request_page
        @conn.get do |req|
          req.params[:page] = page_num
          req.params[:size] = 20
          req.params[:api_key] = ENV['NASA_API_KEY']
        end
      end

      def json(response)
        JSON.parse(response.body)
      end

      def process_response(response)
        parsed_body = json(response)
        update_pagination parsed_body
        @list_loader.process parsed_body['near_earth_objects']
      end

      def update_pagination(response_body)
        self.page_num = page_num + 1
        self.total_pages = response_body['page']['total_pages']
      end
    end
  end
end
