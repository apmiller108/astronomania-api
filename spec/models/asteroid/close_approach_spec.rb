require 'rails_helper'

describe Asteroid::CloseApproach do
  let :near_earth_object do
    build :asteroid_near_earth_object
  end

  subject do
    build :asteroid_close_approach,
          near_earth_object: near_earth_object
  end

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :close_approach_date }
    it { is_expected.to validate_presence_of :epoch_date_close_approach }
    it { is_expected.to validate_presence_of :relative_velocity }
    it { is_expected.to validate_presence_of :miss_distance }
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
