require 'rails_helper'

describe 'Asteroid::NearEarthObject #show' do
  let :near_earth_object do
    create :asteroid_near_earth_object
  end

  context 'valid neo_reference_id' do
    before :each do
      get asteroids_near_earth_object_path(near_earth_object)
    end

    it 'responds with 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with near_earth_object JSON' do
      expect(response).to match_response_schema('asteroid_near_earth_object')
    end
  end

  context 'invalid neo_reference_id' do
    it 'responds with 404 status' do
      get asteroids_near_earth_object_path(id: 'non-existent')

      expect(response).to have_http_status :not_found
    end
  end
end
