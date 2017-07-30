require 'csv'

namespace :sample_data do
  desc 'add sample asteroid_near_earth_objects'
  task add_neos: :environment do
    return if ENV['NO_SAMPLE_DATA']

    BASE_PATH = %w[lib tasks sample_data csv].freeze
    CSV_ATTRS = [
      {
        file_name: 'asteroid_near_earth_objects.csv',
        class_name: Asteroid::NearEarthObject
      },
      {
        file_name: 'asteroid_close_approaches.csv',
        class_name: Asteroid::CloseApproach
      },
      {
        file_name: 'asteroid_orbits.csv',
        class_name: Asteroid::Orbit
      }
    ].freeze

    Asteroid::CloseApproach.delete_all
    Asteroid::Orbit.delete_all
    Asteroid::NearEarthObject.delete_all

    CSV_ATTRS.each do |attr|
      csv_path = Rails.root.join(*BASE_PATH, attr[:file_name])
      pluralized_name = attr[:class_name].to_s.underscore.pluralize

      puts "Adding #{pluralized_name}"

      CSV.foreach(csv_path, headers: true).with_index(1) do |row, i|
        row = row.to_h

        case attr[:class_name].to_s
        when 'Asteroid::NearEarthObject'
          diameter = JSON.parse(row['estimated_diameter'])
          if diameter.is_a? String
            row['estimated_diameter'] = JSON.parse(diameter)
          end
        when 'Asteroid::CloseApproach'
          row['relative_velocity'] = JSON.parse(row['relative_velocity'])
          row['miss_distance'] = JSON.parse(row['miss_distance'])
        end

        attr[:class_name].create row
        print "--> #{i} #{pluralized_name} added \r"
        $stdout.flush
      end

      puts "Done adding #{pluralized_name}          "
    end
  end
end
