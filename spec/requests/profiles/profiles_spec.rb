require 'rails_helper'

describe 'profiles' do
  let :user do
    create :user
  end

  describe 'user gets their profile' do
    context 'without auth token' do
      it 'responds with 401 status' do
        get profile_path

        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid auth token' do
      it 'responds with 401 status' do
        get profile_path, headers: { 'Authorization': 'Bearer fake_token' }

        expect(response).to have_http_status(401)
      end
    end

    context 'with valid auth token' do
      before :each do
        get profile_path, headers: authenticated_headers(user)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
