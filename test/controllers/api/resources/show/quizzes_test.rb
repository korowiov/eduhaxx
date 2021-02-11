require_relative '../base_quizzes_test'

module ApiTests
  module ResourcesControllerTests
    module ShowTests
      class QuizzesTest < BaseQuizzesTest
        let(:subject) do
          quizzes.first
        end

        let(:subject_id) do
          subject.id
        end

        let(:make_request) do
          get "/api/resources/#{subject_id}"
        end

        describe 'Successful request' do
          let(:expected_json) do
            serialized_single(subject)
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
      end
    end
  end
end
