require 'rails_helper'
include MockResponses

describe Importer::Asteroids::ListLoader do
  let :twenty_valid_asteroids_list do
    JSON.parse(twenty_valid_asteroids)['near_earth_objects']
  end

  let :nineteen_of_twenty_valid_asteroids_list do
    JSON.parse(nineteen_valid_of_twenty_asteroids)['near_earth_objects']
  end

  subject do
    described_class.new
  end

  context '20 valid and 0 invalid asteroids in list' do
    before :each do
      subject.process twenty_valid_asteroids_list
    end

    it 'creates 20 asteroid_near_earth_object records' do
      expect(Asteroid::NearEarthObject.count).to eq 20
    end

    it 'creates an orbit for each asteroid' do
      expect(Asteroid::NearEarthObject.joins(:orbit).count).to eq 20
    end

    it 'creates 32 asteroid_close_approach records' do
      expect(Asteroid::CloseApproach.count).to eq 32
    end

    it 'counts the number of successfully created asteroids' do
      expect(subject.number_successful).to eq 20
    end

    it 'counts the number of failed attempts to create asteroids' do
      expect(subject.number_failed).to eq 0
    end
  end

  context '19 valid and 1 invalid asteroids in list' do
    before :each do
      subject.process nineteen_of_twenty_valid_asteroids_list
    end

    it 'creates 19 asteroid_near_earth_object records' do
      expect(Asteroid::NearEarthObject.count).to eq 19
    end

    it 'creates an orbit for each asteroid' do
      expect(Asteroid::NearEarthObject.joins(:orbit).count).to eq 19
    end

    it 'creates 32 asteroid_close_approach records' do
      expect(Asteroid::CloseApproach.count).to eq 31
    end

    it 'counts the number of successfully created asteroids' do
      expect(subject.number_successful).to eq 19
    end

    it 'counts the number of failed attempts to create asteroids' do
      expect(subject.number_failed).to eq 1
    end
  end
end
