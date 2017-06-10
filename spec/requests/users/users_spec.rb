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

      let :created_user do
        User.find_by_email valid_params[:user][:email]
      end

      it 'responds with 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'responds with the user JSON schema' do
        expect(response).to match_response_schema('user')
      end

      it 'responds with the user id' do
        expect(json['user']['id']).to eq created_user.id
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

      it 'responds with errors JSON schema' do
        expect(response).to match_response_schema('errors')
      end
    end
  end
end
