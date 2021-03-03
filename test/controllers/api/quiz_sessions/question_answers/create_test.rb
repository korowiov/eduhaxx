require 'test_helper'

module QuizSessionsTests
  module QuizAnswersControllerTests
    class CreateTest < ActionDispatch::IntegrationTest
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

      let(:params) do
        {}
      end

      let(:make_request) do
        post "/api/quiz_sessions/#{subject_id}/question/1/answer", params: params, headers: authentication_headers
      end

      before do
        subject
      end

      describe 'Successful request' do
        let(:params) do
          { answers: [quiz_question.question_options[0].id] }
        end

        it 'responds with created' do
          make_request
          assert_response :created
        end
      end

      describe 'Unsuccessful request' do
        describe 'Empty array' do
          let(:params) do
            { answers: [] }
          end

          it 'responds with unprocessable entity' do
            make_request
            assert_response :unprocessable_entity
          end
        end

        describe 'Too much answers' do
          let(:params) do
            {
              answers:
                [
                  quiz_question.question_options[0].id,
                  quiz_question.question_options[1].id
                ]
            }
          end

          it 'responds with unprocessable entity' do
            make_request
            assert_response :unprocessable_entity
          end
        end

        describe 'Invalid answer id' do
          let(:another_quiz_question_id) do
            subject.questions_order[1]
          end

          let(:another_quiz_question) do
            quiz.quiz_questions.find(another_quiz_question_id)
          end

          let(:params) do
            { answers: [another_quiz_question.question_options[0].id] }
          end

          it 'responds with unprocessable entity' do
            make_request
            assert_response :unprocessable_entity
          end
        end

        describe 'Invalid quiz session id' do
          let(:subject_id) do
            '4a03e82a-1111-1111-1111-7ae47a3aa75e'
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
