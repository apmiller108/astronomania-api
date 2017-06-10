require 'rails_helper'

describe 'User logs in' do
  let :user { create :user }

  context 'with valid credentials' do
    let :valid_credentials do
      {
        authenticate: {
          email: user.email,
          password: user.password
        }
      }
    end

    before :each do
      post tokens_path,
           params: valid_credentials,
           as: :json
    end

    it 'responds with 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'reponds with the token API schema' do
    end

    it 'responds with an auth token' do
    end
  end

  context 'with invalid email' do
    let :invalid_credentials do
      {
        authenticate: {
          email: 'fake@example.com',
          password: 'aintreal'
        }
      }
    end

    it 'responds with 404 status' do
      post tokens_path, params: invalid_credentials, as: :json

      expect(response).to have_http_status :not_found
    end
  end

  context 'with valid email and bad password' do
    let :invalid_credentials do
      {
        authenticate: {
          email: user.email,
          password: '!@$^typo!'
        }
      }
    end

    it 'responds with 404 status' do
      post tokens_path, params: invalid_credentials, as: :json

      expect(response).to have_http_status :not_found
    end
  end
end
