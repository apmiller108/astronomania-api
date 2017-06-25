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

      it 'prints the results to stdout' do
        expect { described_class.call }.to(
          output("1 processed successfully. 0 failed.\n").to_stdout
        )
      end
    end

    context 'when apod attributes are not valid' do
      before :each do
        stub_request(:get, request_url).to_return(status: 200,
                                                  body: invalid_apod)
      end

      it 'prints the results to stdout' do
        expect { described_class.call }.to(
          output("0 processed successfully. 1 failed.\n").to_stdout
        )
      end
    end
  end
  context 'when response status is error' do
    before :each do
      stub_request(:get, request_url).to_return(status: 400,
                                                body: bad_request)
    end

    it 'prints the error message to stdout' do
      expect { described_class.call }.to(
        output(
          "The request failed because 'Uh oh! You did something bad.'\n"
        ).to_stdout
      )
    end
  end
end
