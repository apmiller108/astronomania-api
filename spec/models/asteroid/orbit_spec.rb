require 'rails_helper'

describe Asteroid::Orbit do
  let :near_earth_object do
    build :asteroid_near_earth_object
  end

  subject do
    build :asteroid_orbit, near_earth_object: near_earth_object
  end

  it 'has a vaild factory' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :orbit_id }
    it { is_expected.to validate_presence_of :orbit_determination_date }
    it { is_expected.to validate_presence_of :orbit_uncertainty }
    it { is_expected.to validate_presence_of :minimum_orbit_intersection }
    it { is_expected.to validate_presence_of :jupiter_tisserand_invariant }
    it { is_expected.to validate_presence_of :epoch_osculation }
    it { is_expected.to validate_presence_of :eccentricity }
    it { is_expected.to validate_presence_of :semi_major_axis }
    it { is_expected.to validate_presence_of :inclination }
    it { is_expected.to validate_presence_of :ascending_node_longitude }
    it { is_expected.to validate_presence_of :orbital_period }
    it { is_expected.to validate_presence_of :perihelion_distance }
    it { is_expected.to validate_presence_of :perihelion_argument }
    it { is_expected.to validate_presence_of :perihelion_time }
    it { is_expected.to validate_presence_of :aphelion_distance }
    it { is_expected.to validate_presence_of :mean_anomaly }
    it { is_expected.to validate_presence_of :mean_motion }
    it { is_expected.to validate_presence_of :equinox }
  end

  describe 'associations' do
    it do
      is_expected.to(
        belong_to(:near_earth_object)
          .class_name('Asteroid::NearEarthObject')
          .with_foreign_key(:asteroid_near_earth_object_neo_reference_id)
          .with_primary_key(:neo_reference_id)
      )
    end
  end
end
