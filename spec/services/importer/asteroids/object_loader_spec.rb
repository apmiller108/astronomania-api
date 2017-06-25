require 'rails_helper'
include MockResponses

describe Importer::Asteroids::ObjectLoader do
  let :asteroid_with_valid_attributes do
    JSON.parse(valid_asteroid)
  end

  let :asteroid_with_invalid_attributes do
    JSON.parse(invalid_asteroid)
  end

  subject do
    described_class.new
  end

  describe 'saving a near_earth_object' do
    context 'with valid asteroid attributes' do
      context 'when asteroid is new' do
        before :each do
          subject.create_or_update(asteroid_with_valid_attributes)
        end

        let :asteroid do
          Asteroid::NearEarthObject.find(
            asteroid_with_valid_attributes['neo_reference_id']
          )
        end

        it 'creates the asteroid' do
          expect(asteroid).to be_instance_of(Asteroid::NearEarthObject)
        end

        it 'saves the name' do
          expect(asteroid.name).to eq asteroid_with_valid_attributes['name']
        end

        it 'saves the nasa_jpl_url' do
          expect(asteroid.nasa_jpl_url).to(
            eq asteroid_with_valid_attributes['nasa_jpl_url']
          )
        end

        it 'saves the absolute_magnitude_h' do
          expect(asteroid.absolute_magnitude_h).to(
            eq asteroid_with_valid_attributes['absolute_magnitude_h']
          )
        end

        it 'saves the estimated diameter' do
          expect(asteroid.estimated_diameter).to(
            include(
              asteroid_with_valid_attributes['estimated_diameter']
            )
          )
        end
      end

      context 'when the asteroid alreayd exists' do
        it 'updates the asteroid' do
          existing_neo = create(
            :asteroid_near_earth_object,
            id: asteroid_with_valid_attributes['neo_reference_id'],
            name: 'old_name'
          )

          subject.create_or_update(asteroid_with_valid_attributes)

          expect(existing_neo.reload.name)
            .to eq(asteroid_with_valid_attributes['name'])
        end
      end
    end

    context 'with invalid asteroid attributes' do
      it 'raises an exception' do
        expect do
          subject.create_or_update(asteroid_with_invalid_attributes)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'saving an orbit' do
    context 'with valid orbit attributes' do
      context 'when the orbit is new' do
        it 'creates an associated orbit' do
          subject.create_or_update(asteroid_with_valid_attributes)

          expect(Asteroid::NearEarthObject.take.orbit).to_not be nil
        end
      end

      context 'when the orbit already exists' do
        let! :asteroid do
          create(
            :asteroid_near_earth_object,
            neo_reference_id: asteroid_with_valid_attributes['neo_reference_id']
          )
        end

        let! :orbit do
          create :asteroid_orbit,
                 orbit_id: 999,
                 near_earth_object: asteroid
        end

        it 'updates the orbit' do
          subject.create_or_update(asteroid_with_valid_attributes)

          expect(orbit.reload.orbit_id).to(
            eq(
              asteroid_with_valid_attributes['orbital_data']['orbit_id'].to_i
            )
          )
        end
      end
    end

    context 'with invalid orbit attributes' do
      it 'raises an exception' do
        asteroid_with_valid_attributes['orbital_data']['orbit_id'] = ''

        expect do
          subject.create_or_update(asteroid_with_invalid_attributes)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'saving close approaches' do
    context 'with valid close approach attributes' do
      context 'when close approach is new' do
        it 'creates associated close approaches' do
          subject.create_or_update(asteroid_with_valid_attributes)

          expect(Asteroid::NearEarthObject.take.close_approaches)
            .to_not be_empty
        end
      end

      context 'when the close approach already exists' do
        let! :asteroid do
          create(
            :asteroid_near_earth_object,
            neo_reference_id: asteroid_with_valid_attributes['neo_reference_id']
          )
        end

        let! :close_approach do
          create :asteroid_close_approach,
                 near_earth_object: asteroid,
                 orbiting_body: 'old value'
        end

        it 'updates the close approach' do
          subject.create_or_update(asteroid_with_valid_attributes)

          expect(close_approach.reload.orbiting_body).to(
            eq(
              asteroid_with_valid_attributes['close_approach_data']
                .first['orbiting_body']
            )
          )
        end
      end
    end

    context 'with invalid close approach attributes' do
      it 'raises an exception' do
        asteroid_with_valid_attributes['close_approach_data']
          .first['close_approach_date'] = ''

        expect do
          subject.create_or_update(asteroid_with_invalid_attributes)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
