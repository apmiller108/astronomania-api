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

      it 'responds with the created user' do
      end
    end

    context 'invalid params' do
    end
  end
end
