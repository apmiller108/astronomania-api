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
          Importer::PrintResults.for_request(
            type: :error,
            message: JSON.parse(apod_request.body)['msg']
          )
        end
      end

      private

      def create_or_update_apod
        if @object_loader.create_or_update(JSON.parse(apod_request.body))
          Importer::PrintResults.for_import_completion(
            number_successful: 1,
            number_failed: 0
          )
        else
          Importer::PrintResults.for_import_completion(
            number_successful: 0,
            number_failed: 1
          )
        end
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
