shared_examples 'authenticate' do |endpoint| # rubocop:disable Metrics/BlockLength
  describe 'AuthorizeApiRequest' do # rubocop:disable Metrics/BlockLength
    include ActiveSupport::Testing::TimeHelpers

    context 'when token is fake' do
      it 'return message auth invalid token' do
        headers = { Authorization: 'faker token' }

        get endpoint, headers: headers

        expect(JSON.parse(response.body)['message'].first).to match(/Auth invalid token/)
      end
    end

    context 'when token is empty' do
      it 'return message Auth missing token' do
        headers = { Authorization: '' }

        get endpoint, headers: headers

        expect(JSON.parse(response.body)['message'].first).to match(/Auth missing token/)
      end
    end

    context 'when missing token' do
      it 'return message auth invalid token' do
        get endpoint

        expect(JSON.parse(response.body)['message'].first).to match(/Auth missing token/)
      end
    end

    context 'when token is invalid' do
      it 'return message auth invalid token' do
        params = { email: create(:user).email, password: '12345678' }
        post login_index_path(params)
        headers = { Authorization: JSON.parse(response.body)['access_token'] }
        travel 1.day

        get endpoint, params: params, headers: headers

        expect(JSON.parse(response.body)['message'].first).to match(/Auth invalid token/)
      end
    end
  end
end

RSpec.shared_context 'login' do
  let(:user) { create(:user) }

  before do
    params = { email: user.email, password: '12345678' }

    post login_index_path(params)
  end
end
