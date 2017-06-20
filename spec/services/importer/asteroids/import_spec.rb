require 'rails_helper'
include MockResponses

describe Importer::Asteroids::Import do
  subject do
    described_class.new
  end

  let :request_url do
    "https://api.nasa.gov/neo/rest/v1/neo/browse?api_key="\
    "#{ENV['NASA_API_KEY']}&page=0&size=20"
  end

  before :each do
    stub_request(:get, request_url).and_return(status: 200,
                                               body: twenty_valid_asteroids)
  end

  it 'gets all pages and puts the results' do
    expect { subject.call }.to(
      output("20 processed successfully. 0 failed.\n").to_stdout
    )
  end
end
