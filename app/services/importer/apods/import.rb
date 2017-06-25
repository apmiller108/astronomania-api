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
          @object_loader.create_or_update(JSON.parse(apod_request.body))
        else
          puts apod_request.body['msg']
        end
      end

      private

      def apod_request
        @apod_request ||= @conn.get do |req|
          req.params[:date] = @date.to_s
          req.params[:api_key] = ENV['NASA_API_KEY']
        end
      end
    end
  end
end
