puts 'Seeding database...'
puts "creating asteroid_near_earth_objects, asteroid_close_approaches, "\
     "and asteroid_orbits"

Asteroid::NearEarthObject.destroy_all

neo = Asteroid::NearEarthObject.create!(
  neo_reference_id: '2021277',
  name: '21277 (1996 TO5)',
  nasa_jpl_url: 'http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=2021277',
  absolute_magnitude_h: 16.0,
  is_potentially_hazardous_asteroid: false,
  estimated_diameter: {
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
      "estimated_diameter_max" => 12_303.3967781592
    }
  }
)

neo.close_approaches.create!(
  close_approach_date: '1945-06-07',
  epoch_date_close_approach: '-775328400000',
  relative_velocity: {
    "kilometers_per_second" => 15.5095198576,
    "kilometers_per_hour" => 55_834.2714874122,
    "miles_per_hour" => 34_693.2449694979
  },
  miss_distance: {
    "astronomical" =>  0.0334263473,
    "lunar" => 13.0028495789,
    "kilometers" => 5_000_510.5,
    "miles" => 3_107_173.25
  },
  orbiting_body: "Mars"
)

Asteroid::Orbit.create!(
  near_earth_object: neo,
  orbit_id: 98,
  orbit_determination_date: "2017-04-06 09:29:34",
  orbit_uncertainty: 0,
  minimum_orbit_intersection: 0.313372,
  jupiter_tisserand_invariant: 3.267,
  epoch_osculation: 2_458_000.5,
  eccentricity: 0.5204050681261931,
  semi_major_axis: 2.377065592293492,
  inclination: 20.95047154769285,
  ascending_node_longitude: 167.3995452250696,
  orbital_period: 1338.628834056353,
  perihelion_distance: 1.140028610795568,
  perihelion_argument: 250.179646628075,
  aphelion_distance: 3.614102573791417,
  perihelion_time: 2_458_492.728981364743,
  mean_anomaly: 227.6239232391675,
  mean_motion: 0.2689319031841838,
  equinox: "J2000"
)

puts 'Done seeding. Blast Off!'
