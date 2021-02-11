require 'test_helper'

module SessionsControllerTests
  class ShowTest < ActionDispatch::IntegrationTest
    include SharedContexts::StubIncomingIp
    include SharedContexts::StubSignedAccount

    let(:make_request) { get '/api/session', headers: authentication_headers }

    describe 'Successful request' do
      let(:expected_json) do
        account.slice(:id, :email, :nickname)
      end

      it 'returns 200' do
        make_request
        assert_response :ok
      end

      it 'returns proper json' do
        make_request
        assert_equal expected_json, json_response
      end
    end

    describe 'Unsuccessful request' do
      describe 'Missing authentication headers' do
        it 'returns unauthorized' do
          get '/api/session'
          assert_response :unauthorized
        end
      end

      describe 'Existing authentication tokens are expired' do
        before do
          session.expire!
        end

        it 'returns unauthorized' do
          make_request
          assert_response :unauthorized
        end
      end
    end
  end
end
