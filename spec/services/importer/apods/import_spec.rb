require 'rails_helper'
include MockResponses

describe Importer::Apods::Import do
  let :request_url do
    "https://api.nasa.gov/planetary/apod?api_key="\
    "#{ENV['NASA_API_KEY']}&date=#{Date.current}"
  end

  context 'when response status is success' do
    context 'when apod attributes are valid' do
      before :each do
        stub_request(:get, request_url).to_return(status: 200, body: valid_apod)
      end

      it 'logs the successful import' do
        expect(Rails.logger).to(
          receive(:info).with(
            "Successfully imported APOD for 2017-06-25"
          )
        )

        described_class.call
      end
    end

    context 'when apod attributes are not valid' do
      before :each do
        stub_request(:get, request_url).to_return(status: 200,
                                                  body: invalid_apod)
      end

      it 'logs the validation error' do
        expect(Rails.logger).to(
          receive(:error).with(
            "Failed to import APOD because Validation failed: "\
            "Url can't be blank"
          )
        )

        described_class.call
      end
    end
  end

  context 'when response status is error' do
    before :each do
      stub_request(:get, request_url).to_return(status: 400,
                                                body: bad_request)
    end

    it 'logs the error response message' do
      expect(Rails.logger).to(
        receive(:error).with(
          "Request for APOD failed because: Uh oh! You did something bad."
        )
      )

      described_class.call
    end
  end
end
