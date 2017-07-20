require 'rails_helper'

describe Asteroid::NearEarthObject do
  it 'has a valid factory' do
    expect(build(:asteroid_near_earth_object)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :neo_reference_id }
  end

  describe 'associations' do
    it do
      is_expected.to(
        have_many(:close_approaches)
          .class_name('Asteroid::CloseApproach')
          .with_foreign_key(:asteroid_near_earth_object_neo_reference_id)
      )
    end
  end

  describe 'class methods' do
    describe 'last_updated' do
      xit 'returns the most recent update_at date' do
      end
    end
  end
end
