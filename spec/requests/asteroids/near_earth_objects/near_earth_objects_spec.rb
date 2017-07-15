require 'rails_helper'

describe 'requests for near_earth_objects' do
  describe '#index' do
    before :all do
      create_list :asteroid_near_earth_object, 21, :with_orbit
    end

    after :all do
      Asteroid::NearEarthObject.destroy_all
    end

    context 'without pagination' do
      it 'returns 20 asteroids by default' do
        get asteroids_near_earth_objects_path

        expect(json['data'].count).to eq 20
      end
    end

    context 'with pagination' do
      describe 'page 1 and size of 5' do
        it 'returns 5 asteroids' do
          get asteroids_near_earth_objects_path(page: 1, size: 5)

          expect(json['data'].count).to eq 5
        end
      end
    end
  end

  describe '#show' do
    let :near_earth_object do
      create :asteroid_near_earth_object, :with_orbit, :with_close_approaches
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
end
