require 'test_helper'

module AccountsControllerTests
  class CreateTest < ActionDispatch::IntegrationTest
    let(:params) do
      {
        email: 'test@example.com',
        nickname: 'testaccount',
        password: '1234Pa$$',
        password_confirmation: '1234Pa$$'
      }
    end

    let(:make_request) do
      post '/api/accounts', params: params
    end

    describe 'Successful request' do
      let(:last_created_account) do
        Account.last
      end

      let(:expected_response) do
        {
          'id' => last_created_account.id,
          'nickname' => params[:nickname],
          'email' => params[:email]
        }
      end

      it 'creates new account record' do
        assert_difference 'Account.count', 1 do
          make_request
        end
      end

      it 'returns expected response' do
        make_request
        assert_equal json_response, expected_response
      end

      it 'returns 201' do
        make_request
        assert_response :created
      end
    end

    describe 'Unsuccessful request' do
      describe 'Invalid email' do
        let(:expected_response) do
          { 'email' => ['is invalid'] }
        end

        before do
          params.merge!(email: 'invalid@')
        end

        it 'does not creates new account record' do
          assert_no_difference 'Account.count' do
            make_request
          end
        end

        it 'returns expected response' do
          make_request
          assert_equal json_response, expected_response
        end

        it 'returns 422' do
          make_request
          assert_response :unprocessable_entity
        end
      end

      describe 'Invalid password' do
        let(:expected_response) do
          { 'password_confirmation' => ['is invalid'], 'password' => ['is invalid'] }
        end

        before do
          params.merge!(password: 'pass')
        end

        it 'does not creates new account record' do
          assert_no_difference 'Account.count' do
            make_request
          end
        end

        it 'returns expected response' do
          make_request
          assert_equal json_response, expected_response
        end

        it 'returns 422' do
          make_request
          assert_response :unprocessable_entity
        end
      end

      describe 'Invalid password confirmation' do
        let(:expected_response) do
          { 'password_confirmation' => ['is invalid'] }
        end

        before do
          params.merge!(password_confirmation: 'pass')
        end

        it 'does not creates new account record' do
          assert_no_difference 'Account.count' do
            make_request
          end
        end

        it 'returns expected response' do
          make_request
          assert_equal json_response, expected_response
        end

        it 'returns 422' do
          make_request
          assert_response :unprocessable_entity
        end
      end

      describe 'Email exists' do
        let(:expected_response) do
          { 'email' => ['has already been taken'] }
        end

        before do
          create(:account, email: params[:email])
        end

        it 'does not creates new account record' do
          assert_no_difference 'Account.count' do
            make_request
          end
        end

        it 'returns expected response' do
          make_request
          assert_equal json_response, expected_response
        end

        it 'returns 422' do
          make_request
          assert_response :unprocessable_entity
        end
      end
    end
  end
end
