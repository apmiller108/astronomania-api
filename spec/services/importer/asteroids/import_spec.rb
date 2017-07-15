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

    it 'gets all pages and logs the result' do
      expect(Rails.logger).to(
        receive(:info).with(
          "Completed asteroid import: 20 successful. 0 failed."
        )
      )

      subject.call
    end
  end

  context 'with an error status' do
    before :each do
      stub_request(:get, request_url).and_return(status: 400,
                                                 body: bad_request)
    end

    it 'raises an exception' do
      expect { subject.call }.to(raise_error(Astronomania::ImportError))
    end
  end
end
