require 'test_helper'

module QuizSessionsControllerTests
  class ShowTest < ActionDispatch::IntegrationTest
    include SharedContexts::StubIncomingIp
    include SharedContexts::StubSignedAccount

    let(:quiz) do
      create(:quiz, :published, quiz_questions: build_list(:quiz_question, 10))
    end

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

    let(:subject_id) do
      quiz_session.id
    end

    before do
      quiz_session
    end

    let(:make_request) do
      get "/api/quiz_sessions/#{subject_id}", headers: authentication_headers
    end

    describe 'Successful request' do
      let(:expected_json) do
        {
          'id' => quiz_session.id,
          'questions_order' => quiz_session.questions_order,
          'quiz' => quiz_session.quiz.slice(:id, :name)
        }
      end

      it 'responds with ok' do
        make_request
        assert_response :ok
      end

      it 'responds with proper json' do
        make_request
        assert_equal expected_json, json_response
      end
    end

    describe 'Unsuccessful request' do
      describe 'Invalid id' do
        let(:subject_id) do
          'invalid'
        end

        it 'responds with not found' do
          make_request
          assert_response :not_found
        end
      end

      describe 'Quiz session belongs to another account' do
        let(:another_account) { create(:account) }

        before do
          quiz_session.update(account: another_account)
        end

        it 'responds with forbidden' do
          make_request
          assert_response :forbidden
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
