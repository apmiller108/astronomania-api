module Importer
  module Apods
    class Import
      BASE_URL = 'https://api.nasa.gov/planetary/apod'.freeze

      def self.call(date: Date.current)
        new(date).call
      end

      def initialize(date)
        @conn = Faraday.new(url: BASE_URL)
        @date = date
        @object_loader = Importer::OBJECT_TYPES[:apod].new
      end

      def call
        if apod_request.status == 200
          create_or_update_apod
        else
          Rails.logger.error(
            "Request for APOD failed because: #{parsed_body['msg']}"
          )
        end
      end

      private

      def parsed_body
        JSON.parse apod_request.body
      end

      def create_or_update_apod
        @object_loader.create_or_update(parsed_body)
        Rails.logger.info(
          "Successfully imported APOD for #{parsed_body['date']}"
        )
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error("Failed to import APOD because #{e.message}")
      end

      def apod_request
        @apod_request ||= @conn.get do |req|
          req.params[:date] = @date.to_s
          req.params[:api_key] = ENV['NASA_API_KEY']
        end
      end
    end
  end
end
