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

  context 'with a success status' do
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

  context 'with an error status' do
    before :each do
      stub_request(:get, request_url).and_return(status: 400,
                                                 body: bad_request)
    end

    it 'raises an exception' do
      expect { subject.call }.to(raise_error(Importer::ApiRequestError))
    end
  end
end
