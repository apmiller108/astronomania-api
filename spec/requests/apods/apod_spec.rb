require 'rails_helper'

describe 'requests for apods' do
  describe '#show' do
    before :each do
      create :apod, date: Date.today
      create :apod, date: Date.yesterday
      get apod_path
    end
    it 'responds with 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with apod JSON' do
      expect(response).to match_response_schema 'apod'
    end

    it 'returns the latest apod' do
      expect(json_attrs['date']).to eq Date.today.to_s
    end
  end
end
