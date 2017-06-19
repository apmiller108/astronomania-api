require 'rails_helper'

describe DataImport::AsteroidListLoader do
  let :path_to_recorded_response_body do
    Rails.root.join('spec',
                    'support',
                    'helpers',
                    'api_responses',
                    'neo_list.txt')
  end

  let :parsed_asteroid_list do
    JSON.parse(
      File.open(path_to_recorded_response_body, 'rb', &:read)
    )['near_earth_objects']
  end

  subject do
    described_class.new
  end

  before :each do
    subject.process parsed_asteroid_list
  end

  it 'creates 20 asteroid_near_earth_object records' do
    expect(Asteroid::NearEarthObject.count).to eq 20
  end
end
