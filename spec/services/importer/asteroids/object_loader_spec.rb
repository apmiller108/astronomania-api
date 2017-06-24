require 'rails_helper'
include MockResponses

describe Importer::Asteroids::ObjectLoader do
  let :asteroid do
    JSON.parse(twenty_valid_asteroids)['near_earth_objects'].first
  end

  subject do
    described_class.new(asteroid)
  end

  describe 'saving a near_earth_object' do
    context 'valid asteroid data' do
      context 'new asteroid' do
        it 'creates the asteroid' do
        end
      end

      context 'existing asteroid' do
        it 'updates the asteroid' do
        end
      end
    end

    context 'invalid asteroid data' do
      context 'invalid neo' do
        it 'raises an exception' do
        end
      end
    end
  end

  describe 'saving an orbit' do
  end

  describe 'saving close approaces' do
  end
end
