require 'rails_helper'

describe Asteroid::NearEarthObject do
  it 'has a valid factory' do
    expect(build(:asteroid_near_earth_object)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :absolute_magnitude_h }
    it { is_expected.to validate_presence_of :estimated_diameter }
  end
end
