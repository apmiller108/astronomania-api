module Importer
  class ListLoader
    attr_accessor :number_successful, :number_failed

    def initialize(object_type:)
      @number_successful = 0
      @number_failed = 0
      @object_loader = Importer::OBJECT_TYPES[object_type].new
    end

    def process(list)
      list.each do |item|
        begin
          ActiveRecord::Base.transaction do
            @object_loader.create_or_update item
            self.number_successful = number_successful + 1
          end
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "Failed to save record because: #{e.message}"
          self.number_failed = number_failed + 1
          next
        end
      end
    end
  end
end
