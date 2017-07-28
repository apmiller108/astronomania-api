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
      it 'returns the most recent updated_at date' do
        create_list :asteroid_near_earth_object, 3
        Asteroid::NearEarthObject.last.update updated_at: Time.current + 1.day

        expect(described_class.last_updated)
          .to be_within(1.second).of(Time.current + 1.day)
      end
    end
  end
end
