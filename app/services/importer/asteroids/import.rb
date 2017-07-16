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
        process_response_for page_request
        return log_import_results if page_num == total_pages
        call
      end

      private

      attr_accessor :page_num, :total_pages

      def page_request
        @conn.get do |req|
          req.params[:page] = page_num
          req.params[:size] = 20
          req.params[:api_key] = ENV['NASA_API_KEY']
        end
      end

      def process_response_for(response)
        @parsed_body = JSON.parse(response.body)
        return log_and_raise unless response.status == 200

        update_pagination
        @list_loader.process(@parsed_body['near_earth_objects'])
      end

      def log_and_raise
        Rails.logger.error("Request for NEO page failed: #{error_message}")
        raise Astronomania::ImportError, error_message
      end

      def error_message
        @parsed_body['msg'] || @parsed_body['error']['message']
      end

      def update_pagination
        self.page_num = page_num + 1
        self.total_pages = @parsed_body['page']['total_pages']
      end

      def log_import_results
        Rails.logger.info(
          "Completed asteroid import: #{@list_loader.number_successful} "\
          "successful. #{@list_loader.number_failed} failed."
        )
      end
    end
  end
end
