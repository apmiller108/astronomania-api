require 'rails_helper'

describe 'Asteroid Index' do
  before :all do
    create_list :asteroid_near_earth_object, 21
  end

  after :all do
    Asteroid::NearEarthObject.destroy_all
  end

  context 'without pagination' do
    before :each do
      get asteroids_near_earth_objects_path
    end

    it 'returns 20 asteroids by default' do
      expect(json['data'].count).to eq 20
    end
  end
end
