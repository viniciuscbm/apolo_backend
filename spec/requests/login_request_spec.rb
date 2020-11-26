require 'rails_helper'

RSpec.describe 'Login', type: :request do # rubocop:disable Metrics/BlockLength
  describe '#create' do # rubocop:disable Metrics/BlockLength
    context 'when the request is a success' do
      include_context 'login'

      it 'return status code ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'return valid token with user_id' do
        token = JSON.parse(response.body)['access_token']

        user_id = Api::JsonWebToken.decode(token)['user_id']

        expect(user_id).to eq(user.id)
      end

      it 'returns a valid token with the expiration time in seconds' do
        token = JSON.parse(response.body)['access_token']

        exp = Api::JsonWebToken.decode(token)['exp']

        expect(exp).to eq(6.hours.from_now.to_time.to_i)
      end
    end

    context 'when the request fails' do
      before do
        params = {
          email: 'faker@email.com',
          password: '12345678'
        }

        post login_index_path(params)
      end

      it 'return status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'return error message' do
        expect(JSON.parse(response.body)).to eq({ 'message' => ['Auth invalid credentials'] })
      end
    end
  end
end
