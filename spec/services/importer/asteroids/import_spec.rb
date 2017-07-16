require 'rails_helper'
include MockResponses

describe Importer::Asteroids::Import do
  subject do
    described_class.new
  end

  let :request_url_1 do
    "https://api.nasa.gov/neo/rest/v1/neo/browse?api_key="\
    "#{ENV['NASA_API_KEY']}&page=0&size=20"
  end

  let :request_url_2 do
    "https://api.nasa.gov/neo/rest/v1/neo/browse?api_key="\
    "#{ENV['NASA_API_KEY']}&page=1&size=20"
  end

  context 'with a success status' do
    before :each do
      stub_request(:get, request_url_1).and_return(
        status: 200,
        body: twenty_valid_asteroids
      )

      stub_request(:get, request_url_2).and_return(
        status: 200,
        body: twenty_valid_asteroids(page: 2)
      )
    end

    it 'gets all pages and logs the result' do
      expect(Rails.logger).to(
        receive(:info).with(
          "Completed asteroid import: 40 successful. 0 failed."
        )
      )

      subject.call
    end
  end

  context 'with an error status' do
    before :each do
      stub_request(:get, request_url_1).and_return(status: 400,
                                                   body: bad_request)

      stub_request(:get, request_url_2).and_return(
        status: 400,
        body: twenty_valid_asteroids(page: 2)
      )
    end

    it 'raises an exception' do
      expect { subject.call }.to(raise_error(Astronomania::ImportError))
    end

    it 'logs the error' do
      expect(Rails.logger).to(
        receive(:error).with(
          "Request for NEO page failed: Uh oh! You did something bad."
        )
      )
      begin
        subject.call
      rescue Astronomania::ImportError
        # Rescuing this so I can test the logging.
        nil
      end
    end

    it 'does not try to import any more pages' do
      begin
        subject.call
      rescue Astronomania::ImportError
        # Rescuing this so I can complete this test
        expect(Asteroid::NearEarthObject.count).to eq 0
      end
    end
  end
end
