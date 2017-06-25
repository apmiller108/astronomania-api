module Importer
  module Asteroids
    BASE_URL = 'https://api.nasa.gov/neo/rest/v1/neo/browse'.freeze

    class Import
      def self.call
        new.call
      end

      def initialize
        @conn = Faraday.new(url: BASE_URL)
        @list_loader = Importer::ListLoader.new(object_type: :asteroid)
        @page_num = 0
        @total_pages = 0
      end

      def call
        process_response request_page
        if page_num == total_pages
          print_import_results
        else
          print_page_results
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

      def process_response(response)
        parsed_body = JSON.parse(response.body)
        update_pagination parsed_body
        @list_loader.process parsed_body['near_earth_objects']
      end

      def update_pagination(response_body)
        self.page_num = page_num + 1
        self.total_pages = response_body['page']['total_pages']
      end

      def print_import_results
        Importer::PrintResults.for_import_completion(
          number_successful: @list_loader.number_successful,
          number_failed: @list_loader.number_failed
        )
      end

      def print_page_results
        Importer::PrintResults.for_page_completion(page_num: page_num,
                                                   total_pages: total_pages)
      end
    end
  end
end
