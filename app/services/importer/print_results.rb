module Importer
  module PrintResults
    def self.for_page_completion(page_num:, total_pages:)
      print "completed #{page_num} of #{total_pages} \r"
      $stdout.flush
    end

    def self.for_import_completion(number_successful:, number_failed:)
      puts "#{number_successful} processed successfully. "\
           "#{number_failed} failed."
    end

    def self.for_request(type:, message:)
      case type
      when :error
        puts "The request failed because '#{message}'"
      when :sucess
        puts "The request succeeded: #{message}"
      end
    end
  end
end
