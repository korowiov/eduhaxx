require 'test_helper'

module SessionsControllerTests
  class CreateTest < ActionDispatch::IntegrationTest
    include SharedContexts::StubIncomingIp
    include SharedContexts::StubSignedAccount

    let(:params) do
      {
        email: account.email,
        password: account_password
      }
    end
    let(:make_request) { post '/api/session', params: params }

    before do
      stub_incoming_ip!
      Api::Authentication::TokenGenerator
        .stubs(:prepare_tokens)
        .with(account.id)
        .returns(tokens)
    end

    describe 'Successful request' do
      let(:last_created) do
        AuthenticationToken.last
      end

      let(:expected_response) do
        {
          'token' => tokens.last,
          'account_id' => account.id,
          'email' => account.email,
          'nickname' => account.nickname
        }
      end

      it 'creates new authentication token record' do
        assert_difference 'AuthenticationToken.count', 1 do
          make_request
        end
      end

      it 'creates authentication token record for proper account and saves ip' do
        make_request

        assert_equal request_ip, last_created.sign_in_ip
        assert_equal account, last_created.account
        assert_equal tokens.first, last_created.token
        refute last_created.expired
      end

      it 'returns 201 code' do
        make_request
        assert_response :created
      end

      it 'returns expected response' do
        make_request
        assert_equal json_response, expected_response
      end

      describe 'Already three authentication tokens created' do
        let(:another_sessions) do
          create_list(:authentication_token, 3, account: account)
        end

        before do
          account.authentication_tokens.destroy_all
          another_sessions.each_with_index do |session, index|
            session.update(created_at: Time.now - index.minute)
          end
        end

        it 'creates another new authentication token record' do
          assert_difference 'AuthenticationToken.count', 1 do
            make_request
          end
        end

        # it 'sets oldest authentication token as expired' do
        #   make_request
        #   assert another_sessions.last.reload.expired
        # end

        it 'returns 201 code' do
          make_request
          assert_response :created
        end

        it 'returns expected response' do
          make_request
          assert_equal json_response, expected_response
        end
      end
    end

    describe 'Unsuccessful request' do
      describe 'Invalid password' do
        before do
          params.merge!(password: 'invalid password')
        end

        it 'returns 401 code' do
          make_request
          assert_response :unauthorized
        end
      end

      describe 'Invalid nickname' do
        before do
          params.merge!(email: 'invalid@email.com')
        end

        it 'returns 401 code' do
          make_request
          assert_response :unauthorized
        end
      end
    end
  end
end
