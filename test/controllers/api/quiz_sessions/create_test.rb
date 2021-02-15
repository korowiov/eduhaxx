require 'test_helper'

module QuizSessionsControllerTests
  class CreateTest < ActionDispatch::IntegrationTest
    include SharedContexts::StubIncomingIp
    include SharedContexts::StubSignedAccount

    let(:quiz) do
      create(:quiz, :published, quiz_questions: build_list(:quiz_question, 10))
    end

    let(:make_request) do
      post '/api/quiz_sessions', headers: authentication_headers, params: params
    end

    let(:params) do
      { quiz_id: quiz.id }
    end

    let(:last_created) do
      QuizSession.last
    end

    describe 'Successful request' do
      let(:expected_json) do
        { 'id' => last_created.id }
      end

      it 'responds with ok' do
        make_request
        assert_response :ok
      end

      it 'responds with proper json' do
        make_request
        assert_equal expected_json, json_response
      end

      it 'creates new quiz session' do
        assert_difference 'QuizSession.count', 1 do
          make_request
        end
      end

      describe 'Active session for account exists' do
        let(:session_configuration) do
          QuizSessions::Configuration::Build
            .call(quiz: quiz)
        end

        let(:quiz_session) do
          create(
            :quiz_session,
            account: account,
            quiz: quiz,
            configuration: session_configuration
          )
        end

        let(:expected_json) do
          { 'id' => quiz_session.id }
        end

        before do
          quiz_session
        end

        it 'responds with ok' do
          make_request
          assert_response :ok
        end

        it 'responds with proper json, with existing id' do
          make_request
          assert_equal expected_json, json_response
        end

        it 'does not creates new quiz session' do
          assert_no_difference 'QuizSession.count' do
            make_request
          end
        end
      end
    end

    describe 'Unsuccessful request' do
      describe 'Invalid id' do
        let(:params) do
          { quiz_id: 'invalid' }
        end

        it 'responds with mot found' do
          make_request
          assert_response :not_found
        end
      end

      describe 'Not published quiz' do
        before do
          quiz.update(state: 'created')
        end

        it 'responds with mot found' do
          make_request
          assert_response :not_found
        end
      end

      describe 'Unauthorized' do
        let(:authentication_headers) {}

        it 'responds with unauthorized' do
          make_request
          assert_response :unauthorized
        end
      end
    end
  end
end
