require 'rails_helper'

describe 'Asteroid Index' do
  before :all do
    21.times { create :asteroid_near_earth_object }
  end

  context 'without pagination' do
    before :each do
      get asteroids_near_earth_objects_path
    end

    it 'returns 20 asteroids by default' do
      expect(json['near_earth_objects'].count).to eq 20
    end
  end
end
