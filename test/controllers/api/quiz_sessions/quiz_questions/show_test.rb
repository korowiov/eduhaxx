require 'test_helper'

module QuizSessionsTests
  module QuizQuestionsControllerTests
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

      let(:subject) do
        create(
          :quiz_session,
          account: account,
          quiz: quiz,
          configuration: session_configuration
        )
      end

      let(:subject_id) do
        subject.id
      end

      let(:quiz_question_id) do
        subject.questions_order[0]
      end

      let(:quiz_question) do
        quiz.quiz_questions.find(quiz_question_id)
      end

      let(:make_request) do
        get "/api/quiz_sessions/#{subject_id}/question/1", headers: authentication_headers
      end

      before do
        subject
      end

      describe 'Successful request' do
        let(:expected_json) do
          hsh = quiz_question.slice(:id, :content, :question_type)
          hsh['question_options'] =
            quiz_question.question_options.map do |question|
              question.slice(:id, :content)
            end
          hsh
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
        describe 'Invalid quiz session id' do
          let(:subject_id) do
            '4a03e82a-1111-1111-1111-7ae47a3aa75e'
          end

          it 'responds with not found' do
            make_request
            assert_response :not_found
          end
        end

        describe 'Invalid question order' do
          let(:make_request) do
            get "/api/quiz_sessions/#{subject_id}/question/111", headers: authentication_headers
          end

          it 'responds with not found' do
            make_request
            assert_response :not_found
          end
        end

        describe 'Account is not signed in' do
          let(:authentication_headers) do
            {}
          end

          it 'responds unauthorized' do
            make_request
            assert_response :unauthorized
          end
        end
      end
    end
  end
end
