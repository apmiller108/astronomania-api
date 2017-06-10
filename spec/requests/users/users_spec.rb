require 'rails_helper'

describe 'Users API' do
  describe 'creaing a new user' do
    context 'valid params' do
      let :valid_params do
        { user: attributes_for(:user) }
      end

      before :each do
        post users_path, params: valid_params, as: :json
      end

      it 'responds with 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'responds with the user JSON schema' do
        expect(response).to match_response_schema('user')
      end
    end

    context 'invalid params' do
      let :invalid_params do
        {
          user: {
            email: 'invalid_email'
          }
        }
      end

      before :each do
        post users_path, params: invalid_params, as: :json
      end

      it 'responds with 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
