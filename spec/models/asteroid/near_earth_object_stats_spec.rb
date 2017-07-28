require 'rails_helper'

describe Asteroid::NearEarthObjectStats do
  before :each do
    create_list :asteroid_near_earth_object,
                3,
                :with_orbit,
                :with_close_approaches
  end

  subject do
    described_class.new
  end

  describe 'attributes' do
    it 'has the asteroid_near_earth_object_count' do
      expect(subject.near_earth_object_count).to eq 3
    end

    it 'has the asteroid_close_approach count' do
      expect(subject.close_approach_count).to eq 6
    end

    it 'has the last updated date' do
      expect(subject.last_updated.to_date).to eq Date.today
    end

    it 'has the source of the data' do
      expect(subject.source).to eq "NEO data is from the NASA JPL Asteroid "\
                                   "team (http://neo.jpl.nasa.gov/). Data is "\
                                   "imported from NASA's NeoWs (Near Earth "\
                                   "Object Web Service) a RESTful web service "\
                                   "for near earth Asteroid information."
    end

    it 'has the source url of the data' do
      expect(subject.source_info_url).to eq 'https://api.nasa.gov/api.html#NeoWS'
    end
  end
end
