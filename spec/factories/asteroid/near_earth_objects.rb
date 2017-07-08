FactoryGirl.define do
  factory :asteroid_near_earth_object, class: 'Asteroid::NearEarthObject' do
    sequence(:neo_reference_id) { |n| "2021277-#{n}" }
    name '21277 (1996 TO5)'
    nasa_jpl_url 'http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=2021277'
    absolute_magnitude_h 16.0
    is_potentially_hazardous_asteroid false
    estimated_diameter(
      "kilometers" => {
        "estimated_diameter_min" => 1.6770846216,
        "estimated_diameter_max" => 3.750075218
      },
      "meters" => {
        "estimated_diameter_min" => 1677.0846216284,
        "estimated_diameter_max" => 3750.0752179805
      },
      "miles" => {
        "estimated_diameter_min" => 1.0420917484,
        "estimated_diameter_max" => 2.3301879883
      },
      "feet" => {
        "estimated_diameter_min" => 5502.2463100232,
        "estimated_diameter_max" => 12303.3967781592
      }
    )

    trait :with_orbit do
      after :create do |near_earth_object|
        create :asteroid_orbit, near_earth_object: near_earth_object
      end
    end

    trait :with_close_approaches do
      after :create do |near_earth_object|
        create_list(:asteroid_close_approach,
                    2,
                    near_earth_object: near_earth_object)
      end
    end
  end
end
