require 'rails_helper'

describe 'requests for near_earth_objects_stats' do
  describe '#show' do
    before :all do
      create_list :asteroid_near_earth_object, 5, :with_close_approaches
    end

    after :all do
      Asteroid::NearEarthObject.destroy_all
    end

    before :each do
      get asteroids_stats_path
    end

    it 'responds with 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with near_earth_objects_stats JSON' do
      expect(response)
        .to match_response_schema('asteroid_near_earth_objects_stats')
    end
  end
end
