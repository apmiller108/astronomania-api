module DataImport
  class AsteroidListLoader
    attr_accessor :number_successful, :number_failed

    def initialize
      @number_successful = 0
      @number_failed = 0
    end

    def process(list)
      list.each do |item|
        begin
          ActiveRecord::Base.transaction do
            neo = Asteroid::NearEarthObject
                  .find_or_initialize_by(id: item['neo_reference_id'])

            create_or_update_near_earth_object neo, item
            create_or_update_close_approaches neo, item
            create_or_update_orbit neo, item
            self.number_successful = number_successful + 1
          end
        rescue ActiveRecord::RecordInvalid
          self.number_failed = number_failed + 1
          next
        end
      end
    end

    private

    def create_or_update_near_earth_object(neo, item)
      Asteroid::NearEarthObject.attribute_names.each do |name|
        neo[name] = item[name] unless item[name].nil?
      end
      neo.save!
    end

    def create_or_update_close_approaches(neo, item)
      item['close_approach_data'].each do |close_approach|
        approach = neo.close_approaches
                      .find_or_initialize_by(
                        close_approach_date: close_approach['close_approach_date']
                      )

        Asteroid::CloseApproach.attribute_names.each do |name|
          approach[name] = close_approach[name] unless close_approach[name].nil?
        end
        approach.save!
      end
    end

    def create_or_update_orbit(neo, item)
      orbital_data = item['orbital_data']
      orbit = neo.orbit || neo.build_orbit

      Asteroid::Orbit.attribute_names.each do |name|
        orbit[name] = orbital_data[name] unless orbital_data[name].nil?
      end
      orbit.save!
    end
  end
end
