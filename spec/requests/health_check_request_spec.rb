require 'rails_helper'

RSpec.describe 'HealthCheck', type: :request do
  describe '#index' do
    context 'when the request is a success' do
      it 'return status code ok' do
        get health_check_index_path

        expect(response).to have_http_status(:ok)
      end

      it 'return json with environment' do
        get health_check_index_path

        response_body = JSON.parse(response.body)

        expect(response_body['environment']).to eq Rails.env
      end
    end
  end
end
