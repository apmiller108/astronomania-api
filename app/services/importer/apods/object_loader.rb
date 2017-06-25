module Importer
  module Apods
    class ObjectLoader
      def create_or_update(item)
        apod = Apod.find_or_initialize_by(date: item['date'])
        Apod.attribute_names.each do |name|
          apod[name] = item[name] unless item[name].nil?
        end
        apod.save
      end
    end
  end
end
