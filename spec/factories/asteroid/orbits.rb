FactoryGirl.define do
  factory :asteroid_orbit, class: 'Asteroid::Orbit' do
    orbit_id 98
    orbit_determination_date "2017-04-06 09:29:34"
    orbit_uncertainty 0
    minimum_orbit_intersection 0.313372
    jupiter_tisserand_invariant 3.267
    epoch_osculation 2_458_000.5
    eccentricity 0.5204050681261931
    semi_major_axis 2.377065592293492
    inclination 20.95047154769285
    ascending_node_longitude 167.3995452250696
    orbital_period 1338.628834056353
    perihelion_distance 1.140028610795568
    perihelion_argument 250.179646628075
    aphelion_distance 3.614102573791417
    perihelion_time 2_458_492.728981364743
    mean_anomaly 227.6239232391675
    mean_motion 0.2689319031841838
    equinox "J2000"
  end
end
